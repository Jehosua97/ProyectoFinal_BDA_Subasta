--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	20/06/2020
--@Descripcion: Script generador de datos redo
set serveroutput on;
whenever sqlerror exit rollback

--------------------------------------------------
-------- Redo para la tabla CASA y OBJETO-------------------
---------------------------------------------------
declare
j integer := 11;
k integer := 31;
m integer := 8;
l integer := 11;
u integer := 201;
q integer := 201;
i integer;

begin 
    for i in 1..6000 loop      
      
      insert into marca (marca_id, nombre) values (j, dbms_random.string('A',40));
      insert into modelo (modelo_id, nombre, marca_id) values (k, dbms_random.string('A',40), 6);
      INSERT INTO actividad (actividad_id, descripcion) VALUES (m, dbms_random.string('A',40));
      insert into foto_objeto (foto_objeto_id, foto, objeto_id) values (u, '529a8146347f751943529a189c98571d75d56f9e47617f4524957b330bc1ab73', 2);
      insert into historico_status_objeto (historico_status_objeto_id, fecha_status, objeto_id, status_objeto_id) values (q,  sysdate, 297, 3);    
      j := j +1;
      k := k +1;
      m := m +1;
      u := u +1;
      q := q +1;
    end loop;
end;
/

commit;

delete from marca where marca_id > 10;
delete from modelo where modelo_id > 30;
delete from actividad where actividad_id > 7;
delete from foto_objeto where foto_objeto_id > 200;
delete from historico_status_objeto where historico_status_objeto_id > 200;

commit;

select comprador.comprador_id,
  cuenta_banco.clabe
  from comprador
  join cuenta_banco on comprador.comprador_id = cuenta_banco.comprador_id
  order by cuenta_banco.clabe;
select max(password_comprador_id) from password_comprador;


