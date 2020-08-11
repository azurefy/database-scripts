--RECOMPILAR OBJETOS
  select 'alter procedure ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='PROCEDURE' and status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';
  select 'alter trigger ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='TRIGGER' and status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';
  select 'alter view ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='VIEW' and status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';
  select 'alter PACKAGE ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='PACKAGE BODY' and status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';
  select 'alter function ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='FUNCTION' and status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';
  select 'alter MATERIALIZED VIEW ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='MATERIALIZED VIEW' and status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';


  select * from dba_objects where status <> 'VALID' and OBJECT_TYPE <> 'SYNONYM';
  select 'alter synonym ' || owner || '.' || object_name || ' compile; ' from SYS.DBA_OBJECTS where OBJECT_TYPE='SYNONYM' and status <> 'VALID'; 
