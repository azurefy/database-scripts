--VERIFICAR JOB COM LOAD ALTO (DIGITAR PID)
  SELECT a.username, a.osuser, a.program, spid, sid, a.serial# ,module FROM v$session a, v$process b WHERE a.paddr = b.addr AND spid = '&pid';
