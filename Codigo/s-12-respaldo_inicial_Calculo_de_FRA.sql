--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	20/06/2020
--@Descripcion: Configuracion de parámetros necesarios para la configuracion de respaldos
--Se van a crear backups nivel cero todos los dias sabado,ya que la oficina de subastas se encuentra cerrada el fin de semana, así mismo 
--se van a generar backups incrementales diferencial nivel 1 cada día a las 11:00pm, ya que se sabe que el nivel de movimientos
-- en ese horario es bajo, los respaldos estarán ubicados dentro de la FRA (/u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area/)
--debido al espacio en disco con el que se cuneta en la base de daos se tendrá una política de retención de 1 backups, el tamaño
-- total en disco disponible para almacenar estos backups es de 2Gb sin embargo podemos aumentarlo en el momento que sea necesario
--Cabe mencionar que se tiene que tener esta carpeta ya creada
--mkdir -p $ORACLE_BASE2/oradata/CHJOPROY/disk_1/fast-reco-area


--rman target /

--Indicandole que se harán los respaldos en disco y declarando la ruta
configure channel device type disk format '/u05/oradata/CHJOPROY/disk_1/fast-reco-area/backup_%U.bkp' maxpiecesize 2G;

--Desde RMAN para especificar cuantos backups deben ser conservados, en este caso vamos a configurarlo a dos
configure retention policy to redundancy 1;

--Eliminar todos los archive redo logs tanto de la FRA como de ubicaciones externas cuando los archive redo logs han sido respaldados al menos 2 veces en disco
configure archivelog deletion policy to backed up 1 times to disk;

--Tratamos de optimizar el trabajo de backup cuando estas ya han sido respaldados antes
configure backup optimization on;

--Creacion del primer backup desde RMAN
backup database plus archivelog tag autos_full_inicial;
delete obsolete;

select session_key,bs_key,
		size_bytes_display
from v$backup_piece_details;

--UNA VEZ QUE SE LLEGA AQUI, DEBEMOS EJECUTAR EL SCRIPT DE CARGA DIARIA DE TRABAJO PARA DESPUES PODER HACER EL NIVEL 0

--Creando un bakcup incremental diferencial nivel 0
backup as backupset incremental level 0 database plus archivelog tag proy_subasta_nivel_0_1;

--select session_key,bs_key,
--		status,start_time,
--		completion_time,ROUND(elapsed_seconds),
--		elapsed_seconds, deleted,
--size_bytes_display
--from v$backup_piece_details;

--DELETE OBSOLETE;

--EJECUTAR NUEVAMENTE EL SCRIPT DE CARGA DIARIA 

--Creando un bakcup incremental diferencial nivel 1
backup as backupset incremental level 1  database plus archivelog tag proy_subasta_nivel_1_1;

--select session_key,bs_key,
--		status,start_time,
--		completion_time,ROUND(elapsed_seconds),
--		elapsed_seconds, deleted,
--size_bytes_display
--from v$backup_piece_details

--DELETE OBSOLETE;

--EJECUTAR NUEVAMENTE EL SCRIPT DE CARGA DIARIA 

--Creando un bakcup incremental diferencial nivel 1
backup as backupset incremental level 1  database plus archivelog tag proy_subasta_nivel_1_2;

--select session_key,bs_key,
--		status,start_time,
--		completion_time,ROUND(elapsed_seconds),
--		elapsed_seconds, deleted,
--size_bytes_display
--from v$backup_piece_details
--where session_key = 40;

--DELETE OBSOLETE;
