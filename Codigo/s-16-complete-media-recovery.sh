# --@Autores: Chavira Tapia Andrés Uriel
# --			Joya Venegas Jehosua Alan
# --@Fecha	20/06/2020
# --@Descripcion: Instrucción que provoca falla para realizar un Complete Media Recovery

mv fotos_tbs.dbf fotos_tbs.dfb.bak

# Recuperación manual:
# mv fotos_tbs.dbf.bak fotos_tbs.dfb

export ORACLE_SID=chjoproy
rman
connect target "sys@chjoproy/system2 as sysdba"
advise failure;

# Repair script: /u01/app/oracle/diag/rdbms/chjoproy/chjoproy/hm/reco_3059532376.hm
# Contenido:
   restore ( datafile 10 );
   recover datafile 10;
   sql 'alter database datafile 10 online';

# En SQL Plus
alter database open;
