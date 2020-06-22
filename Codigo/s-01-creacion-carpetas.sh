#--@Autores: Chavira Tapia Andrés Uriel
#--			Joya Venegas Jehosua Alan
#--@Fecha	18/06/2020
#--@Descripcion	Creacion de carpetas necesarias para la creación de la BD, y otorgando los permisos corresponientes al usuario oracle

#!/bin/bashs
# C H A V I R A
echo "Creando directorio /u01/app/oracle/oradata/CHJOPROY/disk_1/dbs"
mkdir -p /u01/app/oracle/oradata/CHJOPROY/disk_1/dbs
echo "Creando directorio /u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area/archivelog"
mkdir -p /u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area/archivelog
echo "Creando directorio /u01/app/oracle/oradata/CHJOPROY/disk_2/archivelog"
mkdir -p /u01/app/oracle/oradata/CHJOPROY/disk_2/archivelog
echo "Creando directorio /u01/app/oracle/oradata/CHJOPROY/disk_3/"
mkdir -p /u01/app/oracle/oradata/CHJOPROY/disk_3/
#Cambiando propietario de las carpetas 

chown -R oracle:oinstall /u01/app
chmod -R 755 /u01/app


# J O Y A
#echo "Creando directorio /u05/oradata/CHJOPROY/disk_1/dbs/"
#mkdir -p /u05/oradata/CHJOPROY/disk_1/dbs/
#echo "Creando directorio /u01/app/oracle/oradata/CHJOPROY/disk_1/fast-reco-area/archivelog"
#mkdir -p /u05/oradata/CHJOPROY/disk_1/fast-reco-area/archivelog
#echo "Creando directorio /u05/oradata/CHJOPROY/disk_2/archivelog"
#mkdir -p /u05/oradata/CHJOPROY/disk_2/archivelog
#echo "Creando directorio /u05/oradata/CHJOPROY/disk_3/"
#mkdir -p /u05/oradata/CHJOPROY/disk_3/
#Cambiando propietario de las carpetas 
#chown -R oracle:oinstall /u05/
#chmod -R 755 /u05/

#echo "Carpetas creadas y con permisos, ahora pertenecen al usuario ORACLE"

