#--@Autores: Chavira Tapia Andrés Uriel
#--			Joya Venegas Jehosua Alan
#--@Fecha	19/06/2020
#--@Descripcion	Configuracion de 2 dispachers y 6 shared_servers para la conexión en modo compartido, estos parámetrso son lso sugeridos
#-- sin emabargo es bueno hacer una afinación con forme trabaje la BD.

cat <<'EOF' >> ${ORACLE_HOME}/network/admin/tnsnames.ora
CHJOPROY =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = pc-jajv.fi.unam)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = chjoproy.fi.unam)
    )
  )
CHJOPROY_SHARED =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = pc-jajv.fi.unam)(PORT = 1521))
      (SERVICE=SHARED)
    )
    (CONNECT_DATA =
      (SERVICE_NAME = chjoproy.fi.unam)
    )
  )
EOF
