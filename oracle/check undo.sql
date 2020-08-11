--VERIFICAR UNDO
  select a.tablespace_name vcNome, 
        cast(USAGEMB as int) iOcupado, 
        (cast(SIZEMB as int) - cast(USAGEMB as int)) iLivre, 
        cast(b.USAGEACTIVEMB as int) as iUSAGEACTIVEMB, 
        cast(b.USAGEUNEXPIREDMB as int) as iUSAGEUNEXPIREDMB
        from (select sum(bytes) / 1024 / 1024 SIZEMB, b.tablespace_name
        from dba_data_files a, dba_tablespaces b
        where a.tablespace_name = b.tablespace_name
        and b.tablespace_name in (select value from gv$parameter where name =  'undo_tablespace')
        group by b.tablespace_name) a,
        (select c.tablespace_name, sum(bytes) / 1024 / 1024 USAGEMB,
        SUM(CASE WHEN status = 'ACTIVE' THEN bytes ELSE 0 END)/ 1024 / 1024 USAGEACTIVEMB,
        SUM(CASE WHEN status = 'UNEXPIRED' THEN bytes ELSE 0 END)/ 1024 / 1024 USAGEUNEXPIREDMB
        from DBA_UNDO_EXTENTS c
        where status <> 'EXPIRED'
        group by c.tablespace_name) b
        where a.tablespace_name = b.tablespace_name;
