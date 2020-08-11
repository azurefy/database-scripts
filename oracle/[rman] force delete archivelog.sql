--APAGAR ARCHIVE LOG
  run{
  allocate channel d1 type disk;
  allocate channel d2 type disk;
  allocate channel d3 type disk;
  allocate channel d4 type disk;
  crosscheck archivelog all;
  crosscheck backup;
  delete noprompt obsolete;
  delete noprompt expired backupset;
  delete  noprompt expired  archivelog all ;
  release channel d1;
  release channel d2;
  release channel d3;
  release channel d4;


  delete noprompt force archivelog all completed before 'sysdate-30';
  }