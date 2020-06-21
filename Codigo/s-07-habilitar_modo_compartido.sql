#--@Autores: Chavira Tapia Andrés Uriel
#--			Joya Venegas Jehosua Alan
#--@Fecha	19/06/2020
#--@Descripcion	Configuracion de 2 dispachers y 6 shared_servers para la conexión en modo compartido, estos parámetrso son lso sugeridos
#-- sin emabargo es bueno hacer una afinación con forme trabaje la BD.

alter system set db_domain='fi.unam' scope=spfile;
alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=both;
alter system set shared_servers=6 scope=both;
alter system register;
shutdown;
startup;
