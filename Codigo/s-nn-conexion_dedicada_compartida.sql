--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	19/06/2020
--@Descripcion	Configuracion de 2 dispachers y 6 shared_servers para la conexión en modo compartido, estos parámetrso son lso sugeridos
-- sin emabargo es bueno hacer una afinación con forme trabaje la BD.
alter system set service_names='chjoproy.fi.unam';
shutdown;
startup;
alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=both;
alter system set shared_servers=6 scope=both;

#Agreagar al final del archivo tnsnames.ora
#vi /u01/app/oracle/product/18.0.0/dbhome_1/network/admin/tnsnames.ora
#CHJOPROY_S =
#  (DESCRIPTION =
#    (ADDRESS_LIST =
#      (ADDRESS = (PROTOCOL = TCP)(HOST = pc-jajv.fi.unam)(PORT = 1521))
#       (SERVICE=SHARED)
#    )
#    (CONNECT_DATA =
#      (SERVICE_NAME = chjoproy.fi.unam)
#    )
#  )

alter system register;

#Si llega a aparecer un WARNING al  momento de hacer la conexión usuario@chjoproy_s
#conn system
#@/u01/app/oracle/product/18.0.0/dbhome_1/sqlplus/admin/pupbld.sql

