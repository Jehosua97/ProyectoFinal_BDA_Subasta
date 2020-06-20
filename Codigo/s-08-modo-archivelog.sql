--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	19/06/2020
--@Descripcion: Configuracion de parámetros necesarios para cambiar a modo archivelog, es necesario a haber creado las siguientes carpetas:

--mkdir -p $ORACLE_BASE2/oradata/CHJOPROY/disk_1/fast-reco-area/archivelog
--mkdir -p $ORACLE_BASE2/oradata/CHJOPROY/disk_2/archivelog
--Creacion de pfile de respaldo en caso de una tragedia
create pfile='/u01/app/oracle/oradata/CHJOPROY/disk_1/dbs/initchjoproy.ora.sinArchivelog' from spfile;

--Modificación de parámetros para habilitar archivelog
alter system set log_archive_max_processes=5 scope=spfile;
alter system set log_archive_dest_1='LOCATION=/u01/app/oracle/oradata/CHJOPROY/disk_1/archivelog MANDATORY' scope=spfile;
--Si bien esta ruta se declara fuera de la FRA, en el script de creacion de FRA se modifica para cumplir con que se amalcene dentro de fast-reco-area
alter system set log_archive_dest_2='LOCATION=/u01/app/oracle/oradata/CHJOPROY/disk_2/archivelog' scope=spfile;
alter system set log_archive_format='arch_chjoproy_%t_%s_%r.arc' scope=spfile;
alter system set log_archive_min_succeed_dest=1 scope=spfile;

shutdown
startup mount
alter database archivelog;
shutdown
startup