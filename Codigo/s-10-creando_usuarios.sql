--@Autores: Chavira Tapia Andrés Uriel
--          Joya Venegas Jehosua Alan
--@Fecha  22/06/2020
--@Descripcion  Creacion de usuarios para cada modulo

create user u_obj identified by u_obj
  default tablespace objetos_tbs
  quota unlimited on objetos_tbs
  quota unlimited on historico_tbs
  quota unlimited on fotos_tbs
  quota unlimited on indices_tbs
  quota unlimited on indices_blob_tbs;

grant create table, create session, create procedure, 
  create sequence, select any table to u_obj;


create user u_usr identified by u_usr
  default tablespace compradores_tbs
  quota unlimited on compradores_tbs
  quota unlimited on subastas_tbs
  quota unlimited on indices_tbs
  quota unlimited on indices_blob_tbs;

grant create table, create session, create procedure, 
  create sequence, select any table to u_usr;