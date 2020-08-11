  SELECT sid, 
       serial#, 
       To_char(start_time, 'dd/mm/yyyy hh24:mi:ss') 
       start_time, 
       sofar, 
       totalwork, 
       Round(sofar / totalwork * 100, 2) 
       "% Complete", 
       To_char(start_time + ( ( SYSDATE - start_time ) * 100 / ( 
                              sofar / totalwork * 100 ) ), 
       'dd/mm/yyyy hh24:mi:ss') AS 
       prev_finish 
  FROM   gv$session_longops 
  WHERE  opname LIKE 'RMAN%' 
       AND opname NOT LIKE '%aggregate%' 
       AND totalwork != 0 
       AND sofar <> totalwork 
  ORDER  BY sid;

