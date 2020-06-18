--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	18/06/2020
--@Descripcion	Creacion de carpetas necesarias para la creación de la BD, y otorgando los permisos corresponientes al usuario oracle

create spfile from pfile='$ORACLE_BASE2/oradata/CHJOPROY/disk_1/dbs/initchjoproy.ora';
startup nomount

