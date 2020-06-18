--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	18/06/2020
--@Descripcion	Creacion de base de datos, con table spaces	
	shutdown
	startup nomount
	create database chjoproy
	user sys identified by system2
	user system identified by system2
	
	logfile group 1 (
		'$ORACLE_BASE2/oradata/CHJOPROY/redo01a.log',
		'$ORACLE_BASE2/oradata/CHJOPROY/redo01b.log',
		'$ORACLE_BASE2/oradata/CHJOPROY/redo01c.log') size 50m blocksize 512,
	group 2 (
		'$ORACLE_BASE2/oradata/CHJOPROY/redo02a.log',
		'$ORACLE_BASE2/oradata/CHJOPROY/redo02b.log',
		'$ORACLE_BASE2/oradata/CHJOPROY/redo02c.log') size 50m blocksize 512,
	group 3 (
		'$ORACLE_BASE2/oradata/CHJOPROY/redo03a.log',
		'$ORACLE_BASE2/oradata/CHJOPROY/redo03b.log',
		'$ORACLE_BASE2/oradata/CHJOPROY/redo03c.log') size 50m blocksize 512
	maxloghistory 1
	maxlogfiles 16
	maxlogmembers 3
	maxdatafiles 1024
	character set AL32UTF8
	national character set AL16UTF16
	extent management local
	
	datafile '$ORACLE_BASE2/oradata/CHJOPROY/system01.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	
	sysaux datafile '$ORACLE_BASE2/oradata/CHJOPROY/sysaux01.dbf'
		size 550m reuse autoextend on next 10240k maxsize unlimited
		default tablespace users
	
	datafile '$ORACLE_BASE2/oradata/CHJOPROY/users01.dbf'
		size 500m reuse autoextend on maxsize unlimited
		default temporary tablespace tempts1
	tempfile '$ORACLE_BASE2/oradata/CHJOPROY/temp01.dbf'
		size 20m reuse autoextend on next 640k maxsize unlimited
	
	undo tablespace undotbs1
		datafile '$ORACLE_BASE2/oradata/CHJOPROY/undotbs01.dbf'
		size 200m reuse autoextend on next 5120k maxsize unlimited
	
	user_data tablespace usertbs
		datafile '$ORACLE_BASE2/oradata/CHJOPROY/usertbs01.dbf'
		size 200m reuse autoextend on maxsize unlimited;


--Homologando las contraseñas de SYS, SYSTEM y SYSBACKUP
alter user sys identified by system2;
alter user system identified by system2;
