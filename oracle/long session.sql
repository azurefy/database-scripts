  set lines 200
  col sid for 99999
  col sql_id for a16
  col sql_exec_start for 999999999999
  col event for a40
  col texto for a60
  col schemaname for a16

  alter session set nls_Date_format='dd-mm-yyyy hh24:mi:ss';
  alter session set nls_sort=binary;
  alter session set nls_comp=binary;

  select distinct ses.inst_id,sid,schemaname,
  --serial#,
  --event,
  (sysdate-sql_exec_start)*24*60*60 as segundos_rodando,ses.sql_id,substr(sql.sql_text,1,60) as texto,ses.event
  from gv$session ses,gv$sql sql 
  where ses.sql_id=sql.sql_id 
  and  ((sysdate-sql_exec_start)*24*60*60>=0 and status='ACTIVE' ) OR ( ses.sql_id=sql.sql_id and last_call_et<1 
  and (sysdate-sql_exec_start)*24*60*60>=0)
  order by segundos_rodando desc;