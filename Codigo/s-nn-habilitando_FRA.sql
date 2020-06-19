--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	19/06/2020
--@Descripcion: Configurando parámetros necesarios para poder habilitar la FRA, recordando que se tiene que hacer el cálculo
-- una vez que se tienen valores que simulen la operacion diaria, recordando que se tiene que tener esta carpeta lista
--mkdir -p $ORACLE_BASE2/oradata/CHJOPROY/disk_1/fast-reco-area


--HAY QUE CALCULAR LOS VALORES ANTES DE CORRER ESTE SCRIPT


--Creacion de pfile de respaldo en caso de una tragedia
create pfile='/u01/app/oracle/oradata/CHJOPROY/disk_1/dbs/initchjoproy.ora.sinFRA' from spfile;
--Modificando los parámetros necesarios
ALTER SYSTEM SET db_recovery_file_dest_size = 2065M SCOPE=BOTH;
ALTER SYSTEM SET db_recovery_file_dest='/u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area' scope=both;
ALTER SYSTEM SET db_flashback_retention_target = 1440 SCOPE=BOTH;
--LA segunda copia de los archive redo log almacenada en la FRA
ALTER SYSTEM SET log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DES' SCOPE=spfile;
--Configuracion para que el archivo de control y el spfie se guarden en la FRA (Duda: Dice el enunciado "guardar una de las 
--copias del archivo de control en la FRA, pero en donde mas se guarda las otras copias, y como se hacen ")

--A partir de aqui es en la terminar de RMAN
RMAN TARGET /
configure controlfile autobackup format for device type disk clear;
configure controlfile autobackup format for device type disk to '/u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area/ctl_file%F.bkp';
--Configuracion para que los backups set se guarden en la FRA
configure channel device type disk format '/u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area/backup_%U.bkp' maxpiecesize 1G;



