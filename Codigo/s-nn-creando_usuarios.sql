--@Autores: Chavira Tapia Andrés Uriel
--          Joya Venegas Jehosua Alan
--@Fecha  22/06/2020
--@Descripcion  Creacion de usuarios para cada modulo

create user user_objetos identified by user_objetos
  default tablespace objetos_tbs
  quota unlimited on objetos_tbs
  quota unlimited on historico_tbs
  quota unlimited on fotos_tbs;

grant create table, create session, create procedure, 
	create sequence to user_objetos;


create user user_usuarios identified by mosaproy_recursos
  default tablespace compradores_tbs
  quota unlimited on subastas_tbs;


grant create table, create session, create procedure, 
	create sequence to user_usuarios;

