# --@Autores: Chavira Tapia Andrés Uriel
# --			Joya Venegas Jehosua Alan
# --@Fecha	20/06/2020
# --@Descripcion: Instrucción que provoca falla para realizar un Complete Media Recovery

mv fotos_tbs.dbf fotos_tbs.dfb.bak

#En SQL PLUS:
# startup

# Recuperación manual:
# mv fotos_tbs.dbf.bak fotos_tbs.dfb
# En SQL PLUS:
# alter database datafile 10 online;
# alter database open;

# Recuperación con DRA

export ORACLE_SID=chjoproy
rman
connect target "sys@chjoproy/system2 as sysdba"
list failure;
advise failure;

# Repair script: /u01/app/oracle/diag/rdbms/chjoproy/chjoproy/hm/reco_3059532376.hm
# Contenido:
   restore ( datafile 10 );
   recover datafile 10;
   sql 'alter database datafile 10 online';

# En SQL Plus
alter database open;
