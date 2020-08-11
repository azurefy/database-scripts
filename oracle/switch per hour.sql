--VERIFICAR NUMERO DE SWITCH POR HORA
  SELECT TO_CHAR (FIRST_TIME, 'YYYY-MM-DD') dtData,
    TO_CHAR (FIRST_TIME, 'HH24') nHora,
    COUNT (1) nQuantidade
  FROM V$log_history
  WHERE FIRST_TIME > SYSDATE - 4 AND first_time < TO_DATE((TO_CHAR(sysdate, 'YYYY-MM-DD') || ' ' || TO_CHAR (sysdate, 'HH24') || ':00:00'), 'YYYY-MM-DD hh24:mi:ss')
  GROUP BY TO_CHAR (FIRST_TIME, 'YYYY-MM-DD'), TO_CHAR (FIRST_TIME, 'HH24') order by 1,2;
