#--@Autores: Chavira Tapia Andrés Uriel
#--			 Joya Venegas Jehosua Alan
#--@Fecha	 18/06/2020
#--@DCreación de archivo de password agregando solamente a SYS y SYSBACKUP, creación de archivos de control 
# 	de forma multiplexada, ejecutar desde usuario oracle, una vez terminada la ejecución ejecutar export ORACLE_SID=chjoproy y 
#   sqlplus sys as sysdba

#!/bin/bash
echo "Cambiando la varible ORACLE_SID=chjoproy"
export ORACLE_SID=chjoproy
#Creacion del archivo de password con comando orapwd
echo "Creando archivos de password"
orapwd FILE='$ORACLE_HOME/dbs/orapwchjoproy' \
	FORCE=y \
	SYS=password \
	SYSBACKUP=password

#Creacion de archivo de parametros
echo "Creando archivos de parametros"
echo -e "db_name=chjoproy\n\
control_files=(
	$ORACLE_BASE2/oradata/CHJOPROY/disk_1/control01.ctl,\n\
	$ORACLE_BASE2/oradata/CHJOPROY/disk_2/control02.ctl,\n\
	$ORACLE_BASE2/oradata/CHJOPROY/disk_3/control03.ctl)\n\
	memory_target=768M" > "${ORACLE_BASE2}"/oradata/CHJOPROY/disk_1/dbs/initchjoproy.ora
