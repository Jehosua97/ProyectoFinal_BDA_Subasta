--@Autores: Chavira Tapia Andrés Uriel
--			Joya Venegas Jehosua Alan
--@Fecha	20/06/2020
--@Descripcion: Script generador de datos redo
set serveroutput on;
whenever sqlerror exit rollback

declare
  v_count number;

    cursor cur_insert is
	 	select comprador.comprador_id as id,
			comprador.nombre as name,
			comprador.apellido_paterno as ap_pa,
			comprador.apellido_materno as ap_ma
			comprador.correo_electronico as email,
			comprador.foto_perfil as foto,
			comprador.resenia as r,
			comprador.usuario as user,
			comprador.rfc as unique,
 			comprador.direccion as address,
 			comprador.pais_id as country
 			cuenta_banco.clabe as clabe
    	from comprador 
    	inner join cuenta_banco
    	where comprador.comprador_id <=500
    	order by cuenta_banco.clabe desc;

-- insert
   v_count := 0;
  for r in cur_insert loop
    insert into auto (auto_id, marca,modelo,anio,num_serie,tipo,precio,
      descuento,foto,fecha_status,status_auto_id,agencia_id,cliente_id)
    values(r.auto_id, r.marca,r.modelo,r.anio,r.num_serie,r.tipo,r.precio,
      r.descuento,r.foto,r.fecha_status,r.status_auto_id,r.agencia_id,
      r.cliente_id);
    v_count := v_count + sql%rowcount;
  end loop;

  dbms_output.put_line('Registros insertados en AUTO: '||v_count);

  select max(password_comprador_id) from password_comprador;
  select max(password_comprador_id) from ;