--COPIAR USÁRIO
  set lines 9999;
  set pages 9999;
  undef owner
  prompt CREATE_USER
  select 'create user OLD_USER identified by values ''' || us.password || ''' default tablespace '||u.default_tablespace||' temporary tablespace 
  '||u.temporary_tablespace||';'
  from dba_users u, user$ us
  where u.username=us.name
  and u.username = upper('OLD_USER');
  prompt DBA_SYS_PRIVS
  select 'grant '||privilege||' to '||upper('NEW_USER')||';' from dba_sys_privs where grantee = upper('OLD_USER');
  prompt
  prompt DBA_TAB_PRIVS
  select 'grant '||privilege||' on '||owner||'.'||table_name||' to '||upper('NEW_USER')||';' from dba_tab_privs where grantee = 
  upper('OLD_USER');
  prompt
  prompt DBA_ROLE_PRIVS
  select 'grant '||granted_role||' to '||upper('NEW_USER')||';' from dba_role_privs where grantee = upper('OLD_USER');
  prompt
  /
