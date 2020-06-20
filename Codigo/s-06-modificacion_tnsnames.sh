#--@Autores: Chavira Tapia Andrés Uriel
#--			Joya Venegas Jehosua Alan
#--@Fecha	19/06/2020
#--@Descripcion	Configuracion de archivo tnsnames.ora para poder habulitar el compartido y el dedicado, revisar que HOST coincida con el real

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
