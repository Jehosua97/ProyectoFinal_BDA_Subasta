--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	18/06/2020
--@Descripcion	Creacion de diccionario de datos, este script suele tardar alrrededor de 30 minutos
Prompt SYS:
conn sys as sysdba
Prompt catalog.sql
@?/rdbms/admin/catalog.sql
Prompt catproc.sql
@?/rdbms/admin/catproc.sql
Prompt utlrp.sql
@?/rdbms/admin/utlrp.sql

disconnect
Prompt SYSTEM:
conn system as sysdba
Prompt pupbld.sql
@?/sqlplus/admin/pupbld.sql
