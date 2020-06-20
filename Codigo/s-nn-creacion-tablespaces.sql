#--@Autores:Chavira Tapia Andrés Uriel
#--			Joya Venegas Jehosua Alan
#--@Fecha	18/06/2020
#--@Descripcion	Creación de tablespaces.

--Tablespace de objetos
prompt Creando tablespace de objetos
create tablespace objetos_tbs
	datafile '$ORACLE_BASE/oradata/CHJOPROY/objetos_tbs.dbf' size 300m
	extent management local autoallocate
	segment space management auto;

--Tablespace de compradores
prompt Creando tablespace de compradores
create tablespace compradores_tbs
	datafile '$ORACLE_BASE/oradata/CHJOPROY/compradores_tbs.dbf' size 300m
	extent management local autoallocate
	segment space management auto;

--Tablespace de subastas
prompt Creando tablespace de subastas
create tablespace objetos_tbs
	datafile '$ORACLE_BASE/oradata/CHJOPROY/subastas_tbs.dbf' size 300m
	extent management local autoallocate
	segment space management auto;

--Tablespace de histórico de cambios
prompt Creando tablespace de histórico de cambios
create tablespace historico_tbs
	datafile '$ORACLE_BASE/oradata/CHJOPROY/historico_tbs.dbf' size 100m
	extent management local autoallocate
	segment space management auto;

--Tablespace de fotos
prompt Creando tablespace de fotos
create tablespace fotos_tbs
	datafile '$ORACLE_BASE/oradata/CHJOPROY/fotos_tbs.dbf' size 500m
	extent management local autoallocate
	segment space management auto;

--Tablespace de índices
prompt Creando tablespace de índices
create tablespace indices_tbs
	datafile '$ORACLE_BASE/oradata/CHJOPROY/indices_tbs.dbf' size 300m
	extent management local autoallocate
	segment space management auto;