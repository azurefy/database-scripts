--VERIFICAR JOBS COM MAIS DE 3 HORAS                           
  col job_name format a30
  col owner format a30
  col elapsed_time format a30
  --select owner,job_name,start_date,state from dba_scheduler_jobs where state='RUNNING' and elapsed_time > interval '3' hour;
  select owner,job_name,elapsed_time from all_scheduler_running_jobs where elapsed_time > interval '3' hour;
