--SQL VERIFICAR BACKUPS
  --master,model and temp doesnt have backups
  SELECT name FROM master.sys.databases 
  where name  not in
  (
    select database_name
  --,backup_start_date 
  from msdb.dbo.backupset
  where backup_start_date between '2019-02-17 02:00:00' and '2019-02-17 23:00:00'
    and  type = 'I'
  )