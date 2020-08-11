--VERIFICAR CAMINHO TABLESPACE & VERIFICAR TAMANHO DATAFILE 
    col tablespace_name format a20
    col file_name format a50
    col FILE_NAME for a90
    select file_id, 
    file_name,
    tablespace_name, 
    round(bytes/1024/1024) size_mb, 
    blocks, autoextensible, 
    increment_by, 
    round(maxbytes/1024/1024) max_mb from dba_data_files where tablespace_name in ('&TABLESPACE_NAME')  order by 1;
