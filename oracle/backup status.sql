  select 
          recid, 
          STATUS,
          OBJECT_TYPE,
          to_char(start_time,'yyyy-mm-dd hh24:mi:ss') as "START_TIME",
          to_char(end_time,'yyyy-mm-dd hh24:mi:ss') as "END_TIME",
          cast((output_bytes/1024/1024) as int) as "TAMANHO_MB", 
          NULL AS nQtde_ControlFile, 
          NULL AS nQtde_DataFile_FULL, 
          NULL AS nQtde_DataFile_Level0, 
          NULL AS nQtde_DataFile_Level1, 
          NULL AS nQtde_Archivelog, 
          NULL AS output_instance,
          NULL AS incremental_level
          from v$rman_status
        where operation IN ('BACKUP') and status not like 'RUNNING%' and 
            trunc(end_time)>=trunc(sysdate-2) AND 
            OBJECT_TYPE NOT IN ('DB FULL', 'ARCHIVELOG', 'DB INCR')

        UNION ALL
        select
          j.session_recid AS recid, 
          j.status AS STATUS, 
          j.input_type AS OBJECT_TYPE, 
          to_char(j.start_time,'yyyy-mm-dd hh24:mi:ss') as "START_TIME",  
          to_char(j.end_time,'yyyy-mm-dd hh24:mi:ss') as "END_TIME", 
          cast((j.output_bytes/1024/1024) as int) as "TAMANHO_MB" , 
          x.cf AS nQtde_ControlFile, 
          x.df AS nQtde_DataFile_FULL, 
          x.i0 AS nQtde_DataFile_Level0, 
          x.i1 AS nQtde_DataFile_Level1, 
          x.l AS nQtde_Archivelog, 
          ro.inst_id output_instance,
          incremental_level
        from V$RMAN_BACKUP_JOB_DETAILS j
          left outer join (select
                    d.session_recid, d.session_stamp,
                    sum(case when d.controlfile_included = 'YES' then d.pieces else 0 end) CF,
                    sum(case when d.controlfile_included = 'NO'
                        and d.backup_type||d.incremental_level = 'D' then d.pieces else 0 end) DF,
                    sum(case when d.backup_type||d.incremental_level = 'D0' then d.pieces else 0 end) I0,
                    sum(case when d.backup_type||d.incremental_level = 'I1' then d.pieces else 0 end) I1,
                    sum(case when d.backup_type = 'L' then d.pieces else 0 end) L, 
                    MAX(d.incremental_level) incremental_level
                  from
                    V$BACKUP_SET_DETAILS d
                    join V$BACKUP_SET s on s.set_stamp = d.set_stamp and s.set_count = d.set_count
                  where s.input_file_scan_only = 'NO'
                  group by d.session_recid, d.session_stamp) x
          on x.session_recid = j.session_recid and x.session_stamp = j.session_stamp
          left outer join (select o.session_recid, o.session_stamp, min(inst_id) inst_id
                  from GV$RMAN_OUTPUT o
                  group by o.session_recid, o.session_stamp)
          ro on ro.session_recid = j.session_recid and ro.session_stamp = j.session_stamp
        where j.start_time > trunc(sysdate)-2 AND j.status not like 'RUNNING%' order by 4 desc;
