-- KILL SESSION 
alter system kill session 'SID, SERIAL' immediate;

-- CHECK IF ITS BIGFILE
select tablespace_name,bigfile from dba_tablespace where tablespace_name='TABLESPACE_NAME';

-- RESIZE DATAFILE
alter database datafile '+' resize 22000M;

-- ADD DATAFILE ASM
alter tablespace NOME_DA_TABLESPACE add datafile '+DATA' size 31G autoextend on next 1G maxsize 31G;

-- ADD DATAFILE FILESYSTEM
ALTER TABLESPACE "Nome da Tablespace" ADD DATAFILE '/u01/oracle/oradata/orcl/system02.dbf' SIZE "TAMANHO INICIAL" autoextend on maxsize "TAMANHO MAXIMO";

-- database block size
show parameter db_block_size;

-- old sessions (>120)
select * FROM V$SESSION where status = 'ACTIVE' and username is not null and sql_id is not null and ROUND(((SYSDATE - SQL_EXEC_START)*24*60),-1) >120;

-- GRANT
grant select on OWNER.TABLEK to USER;

-- PDB Errors
select * from PDB_PLUG_IN_VIOLATIONS

-- Number of processes 
select resource_name,current_utilization,max_utilization from v$resource_limit where resource_name='processes';

-- Dataguard time
select name, value from v$dataguard_stats;

-- unlock user
select 'alter user &&USRNAME identified by values ''' || password || ''' account unlock;' from user$ where name='&&USRNAME';

-- Alter datafile to its max size 
select 'alter database datafile ''' || file_name || ''' resize 32767M;' from dba_data_files where tablespace_name in ('&TABLESPACE_NAME');

-- Create Synonym
Select  'CREATE SYNONYM '||OBJECT_NAME||' FOR '||OWNER||'.'||OBJECT_NAME||' ; ' from dba_objects where object_type='TABLE' and owner='&USER';

