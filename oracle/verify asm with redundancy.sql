  set lines 250 
  set pages 1000 
  SELECT name, 
        TYPE, 
        ( CASE 
            WHEN TYPE = 'HIGH' THEN Round(( total_mb / 1024 ) / 3) 
            WHEN TYPE = 'NORMAL' THEN Round(( total_mb / 1024 ) / 2) 
            WHEN TYPE IN( 'EXTERNAL,UNPROT' ) THEN Round(( total_mb / 1024 ) / 1) 
          END )                                                   AS TAMANHO_GB, 
        ( CASE 
            WHEN TYPE = 'HIGH' THEN Round(( total_mb / 1024 - free_mb / 1024 ) / 
                                          3) 
            WHEN TYPE = 'NORMAL' THEN Round(( total_mb / 1024 - free_mb / 1024 ) 
                                            / 2) 
            WHEN TYPE IN( 'EXTERNAL,UNPROT' ) THEN Round(( total_mb / 1024 - 
                                                            free_mb / 1024 ) / 1) 
          END )                                                   AS USADO_GB, 
        ( CASE 
            WHEN TYPE = 'HIGH' THEN Round(( free_mb / 1024 ) / 3) 
            WHEN TYPE = 'NORMAL' THEN Round(( free_mb / 1024 ) / 2) 
            WHEN TYPE IN( 'EXTERNAL,UNPROT' ) THEN Round(( free_mb / 1024 ) / 1) 
          END )                                                   AS LIVRE_GB, 
        Round(( ( ( total_mb - free_mb ) / total_mb ) * 100 ), 2) "%USADO" 
  FROM   v$asm_diskgroup 
  ORDER  BY 6 DESC;
