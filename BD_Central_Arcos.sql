PGDMP     +    &                x           BD_Central_Arcos    10.10    10.10 �    z           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            {           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            |           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            }           1262    62579    BD_Central_Arcos    DATABASE     �   CREATE DATABASE "BD_Central_Arcos" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Mexico.1252' LC_CTYPE = 'Spanish_Mexico.1252';
 "   DROP DATABASE "BD_Central_Arcos";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            ~           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                       0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    95359    sp_acceso_datos_db()    FUNCTION       CREATE FUNCTION public.sp_acceso_datos_db() RETURNS TABLE(nombre character varying, accesodatos bit)
    LANGUAGE plpgsql
    AS $$
	declare validacion_niv integer;
BEGIN
return query 
	select oa.nombre_corto as nombre, oa.accesodatos as accesodatos from origen_alerta oa;
END;
$$;
 +   DROP FUNCTION public.sp_acceso_datos_db();
       public       postgres    false    3    1            �            1255    103555 $   sp_actualizar_conexion_arco(integer)    FUNCTION     h  CREATE FUNCTION public.sp_actualizar_conexion_arco(p_id_arco integer) RETURNS TABLE(codigo integer, respuesta character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_arco integer;
BEGIN
validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco);

if(validacion_arco>=1)then
	update lector set fecha_reporte=now() where id_lector=p_id_arco and tipo_lector='1';
	return query
	select (001) as codigo, ('Operacion exitosa.')::character varying as respuesta;
else
	return query
		select (00) as codigo, ('El arco no existe.')::character varying as respuesta;
end if;
END;
$$;
 E   DROP FUNCTION public.sp_actualizar_conexion_arco(p_id_arco integer);
       public       postgres    false    1    3            �            1255    62848 ^   sp_actualizar_ubicacion_arco(character varying, character varying, integer, character varying)    FUNCTION       CREATE FUNCTION public.sp_actualizar_ubicacion_arco(p_usuario character varying, p_contrasena character varying, p_id_arco integer, p_ubicacion character varying) RETURNS TABLE(codigo integer, respuesta character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE validacion_usuario integer;
	declare validacion_arco integer;
BEGIN
	validacion_usuario:= (select count(u.id_usuario) from usuario u where u.usuario=p_usuario and u.contrasena=p_contrasena);
validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco);
if(validacion_arco>=1)then
	if(validacion_usuario > 0)then
		update lector set ubicacion=p_ubicacion where id_lector=p_id_arco and tipo_lector='1';
		return query
		select (001) as codigo, ('Operacion exitosa.')::character varying as respuesta;
	else
		return query
		select (00) as codigo, ('Error en los datos del usuario')::character varying as respuesta;
	end if;
else
	return query
		select (00) as codigo, ('El arco no existe.')::character varying as respuesta;
end if;
END;
$$;
 �   DROP FUNCTION public.sp_actualizar_ubicacion_arco(p_usuario character varying, p_contrasena character varying, p_id_arco integer, p_ubicacion character varying);
       public       postgres    false    3    1            �            1255    95358    sp_advertencias_promedio()    FUNCTION     �  CREATE FUNCTION public.sp_advertencias_promedio() RETURNS TABLE(tipo_registro character varying, promedio double precision)
    LANGUAGE plpgsql
    AS $$
	declare n_total_registros integer;
BEGIN
	
	n_total_registros := (select count(id_alerta) from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta = cat.id_cat_alerta
		where cat.tipo_lector = '1');

	return query
   select 'Informativo'::character varying as tipo_registro, ((count(id_alerta)*100)/n_total_registros):: float as promedio from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta = cat.id_cat_alerta
		where cat.tipo_registro='1' and cat.tipo_lector = '1'
	union
	select 'Advertencia'::character varying as tipo_registro, ((count(id_alerta)*100)/n_total_registros):: float as promedio from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta = cat.id_cat_alerta
		where cat.tipo_registro='2' and cat.tipo_lector = '1'
	union
	select 'Critico'::character varying as tipo_registro, ((count(id_alerta)*100)/n_total_registros):: float as promedio from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta = cat.id_cat_alerta
		where cat.tipo_registro='3' and cat.tipo_lector = '1';
END;
$$;
 1   DROP FUNCTION public.sp_advertencias_promedio();
       public       postgres    false    3    1            �            1255    62850 8   sp_agregar_usuario(character varying, character varying)    FUNCTION     |  CREATE FUNCTION public.sp_agregar_usuario(p_usuario character varying, p_contrasena character varying) RETURNS TABLE(codigo integer, respuesta character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	insert into usuario (usuario,contrasena) values (p_usuario,p_contrasena);
	return query--
	select (001) as codigo, ('Operacion exitosa.')::character varying as respuesta;
END;
$$;
 f   DROP FUNCTION public.sp_agregar_usuario(p_usuario character varying, p_contrasena character varying);
       public       postgres    false    1    3            �            1255    103552    sp_arcos_operando()    FUNCTION     R  CREATE FUNCTION public.sp_arcos_operando() RETURNS TABLE(operando integer, arcos integer)
    LANGUAGE plpgsql
    AS $$

BEGIN
return query 
	select (select count(ls.id_lector) from lector ls where ls.tipo_lector=1 and ls.estado=1)::integer as operando, count(l.id_lector)::integer as arcos from lector l where l.tipo_lector=1;
END;
$$;
 *   DROP FUNCTION public.sp_arcos_operando();
       public       postgres    false    1    3            �            1255    62854    sp_cat_alerta_arco()    FUNCTION     '  CREATE FUNCTION public.sp_cat_alerta_arco() RETURNS TABLE(id_cat_alerta integer, nombre character varying, tipo_registro integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
	select cat.id_cat_alerta, cat.nombre, cat.tipo_registro from cat_alerta cat where cat.tipo_lector='0';	
END;
$$;
 +   DROP FUNCTION public.sp_cat_alerta_arco();
       public       postgres    false    1    3            �            1255    62855    sp_cat_alerta_vehiculo()    FUNCTION     +  CREATE FUNCTION public.sp_cat_alerta_vehiculo() RETURNS TABLE(id_cat_alerta integer, nombre character varying, tipo_registro integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
	select cat.id_cat_alerta, cat.nombre, cat.tipo_registro from cat_alerta cat where cat.tipo_lector='1';	
END;
$$;
 /   DROP FUNCTION public.sp_cat_alerta_vehiculo();
       public       postgres    false    3    1            �            1255    103550 G   sp_consultar_alerta_arcos_interfaz1(integer, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.sp_consultar_alerta_arcos_interfaz1(p_dias integer, p_informativo integer, p_advertencia integer, p_critico integer) RETURNS TABLE(tipo_registro integer, fecha_hora timestamp without time zone, nombre_arco character varying, descripcion character varying, placa_niv character varying, fuente_informacion character varying)
    LANGUAGE plpgsql
    AS $$
	declare fecha interval;
BEGIN
	if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now();
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
					-- Se juntaron las consultas para traer los datos que sea advertencia e infomativo
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='1'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='2'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion,('PLACA:'|| urr.placa ||' NIV:' || al.fk_id_objeto)::character varying as placa_niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta inner join unidad_registro_repuve urr on al.fk_id_objeto = urr.niv
					where cat.tipo_lector='1' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='1';
			end if;
END;
$$;
 �   DROP FUNCTION public.sp_consultar_alerta_arcos_interfaz1(p_dias integer, p_informativo integer, p_advertencia integer, p_critico integer);
       public       postgres    false    3    1            �            1255    103554 >   sp_consultar_alertas_arcos(integer, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.sp_consultar_alertas_arcos(p_dias integer, p_informativo integer, p_advertencia integer, p_critico integer) RETURNS TABLE(fecha_hora timestamp without time zone, nombre_arco character varying, nombre_alerta character varying, ubicacion character varying, tipo_registro integer)
    LANGUAGE plpgsql
    AS $$
	declare fecha interval;
BEGIN
	if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() order by al.fecha_hora asc;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
					-- Se juntaron las consultas para traer los datos que sea advertencia e infomativo
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='1'
					union
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='1'
					UNION
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='2'
					UNION
					select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='3' order by al.fecha_hora asc;
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='2' order by al.fecha_hora asc;
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select al.fecha_hora as fecha_hora, l.nombre as nombre_arco, cat.nombre as nombre_alerta, l.ubicacion as ubicacion, cat.tipo_registro as tipo_registro
					from lector l inner join alerta al on l.id_lector = al.fk_id_lector 
					inner join cat_alerta cat on cat.id_cat_alerta = al.fk_id_cat_alerta
					where cat.tipo_lector='0' and al.fecha_hora between (current_date - (p_dias || ' days')::interval) and now() and cat.tipo_registro='1' order by al.fecha_hora asc;
			end if;
END;
$$;
 �   DROP FUNCTION public.sp_consultar_alertas_arcos(p_dias integer, p_informativo integer, p_advertencia integer, p_critico integer);
       public       postgres    false    3    1            �            1255    95354    sp_consultar_arcos()    FUNCTION     �   CREATE FUNCTION public.sp_consultar_arcos() RETURNS TABLE(id_lector integer, nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	return query 
	select l.id_lector as id_lector, l.nombre as nombre from lector l;
	
END;
$$;
 +   DROP FUNCTION public.sp_consultar_arcos();
       public       postgres    false    1    3            �            1255    62846 L   sp_consultar_informacion_arco(character varying, character varying, integer)    FUNCTION     t  CREATE FUNCTION public.sp_consultar_informacion_arco(p_usuario character varying, p_contrasena character varying, p_id_arco integer) RETURNS TABLE(nombre character varying, tipo bit, ubicacion character varying, descripcion character varying)
    LANGUAGE plpgsql
    AS $$
	DECLARE validacion_usuario integer;
	declare validacion_arco integer;
 
BEGIN
	validacion_usuario:= (select count(u.id_usuario) from usuario u where u.usuario=p_usuario and u.contrasena=p_contrasena);
	validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco);
	if(validacion_arco>=1)then
		if(validacion_usuario > 0)then
			return query
			select ar.nombre, ar.tipo , ar.ubicacion , ar.descripcion  from lector ar where ar.id_lector=p_id_arco;
		else
			return query
			select 'Error en los datos del usuario.'::character varying as nombre, 0::bit as tipo , ''::character varying as ubicacion, ''::character varying as descripcion;
		end if;
	else
		return query
			select 'El arco no existe.'::character varying as nombre, 0::bit as tipo , ''::character varying as ubicacion, ''::character varying as descripcion;
	end if;
END;
$$;
 �   DROP FUNCTION public.sp_consultar_informacion_arco(p_usuario character varying, p_contrasena character varying, p_id_arco integer);
       public       postgres    false    3    1            �            1255    70773 �   sp_consultar_lectura_vehiculo_niv(character varying, timestamp without time zone, timestamp without time zone, character varying, integer, integer, integer)    FUNCTION     K7  CREATE FUNCTION public.sp_consultar_lectura_vehiculo_niv(p_niv character varying, p_fecha_inicial timestamp without time zone, p_fecha_final timestamp without time zone, p_id_arco character varying, p_informativo integer, p_advertencia integer, p_critico integer) RETURNS TABLE(tipo_registro integer, fecha_hora timestamp without time zone, nombre_arco character varying, descripcion character varying, niv character varying, fuente_informacion character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_niv integer;
	declare validacion_arco integer;
	declare validacion_leyenda integer;
BEGIN
	validacion_niv := (select count(urr.id_urr) from unidad_registro_repuve urr where urr.niv=p_niv);
	
	if(p_id_arco='todos') then
		
	else
		validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco::integer);
	end if;
	
	-- Validacion si existe el niv
	if(validacion_niv>=1)then
		--Validacion si se mostraran todos los arcos
		if(p_id_arco='todos') then
			--Validacion que tipo de alertas se mostraran
			if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
					-- Se juntaron las consultas para traer los datos que sea advertencia e infomativo
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1';
			else
			end if;
		elsif(validacion_arco>=1)then
		-- Validacion con ID de arco
			--Validacion que tipo de alertas se mostraran
			if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2';
			
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					where cat.tipo_lector='1' and al.fk_id_objeto=p_niv and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1';
			end if;
		end if;
	end if;
	
END;
$$;
   DROP FUNCTION public.sp_consultar_lectura_vehiculo_niv(p_niv character varying, p_fecha_inicial timestamp without time zone, p_fecha_final timestamp without time zone, p_id_arco character varying, p_informativo integer, p_advertencia integer, p_critico integer);
       public       postgres    false    3    1            �            1255    78973 �   sp_consultar_lectura_vehiculo_placa(character varying, timestamp without time zone, timestamp without time zone, character varying, integer, integer, integer)    FUNCTION     �;  CREATE FUNCTION public.sp_consultar_lectura_vehiculo_placa(p_placa character varying, p_fecha_inicial timestamp without time zone, p_fecha_final timestamp without time zone, p_id_arco character varying, p_informativo integer, p_advertencia integer, p_critico integer) RETURNS TABLE(tipo_registro integer, fecha_hora timestamp without time zone, nombre_arco character varying, descripcion character varying, niv character varying, fuente_informacion character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_arco integer;
BEGIN

	if(p_id_arco='todos') then
		
	else
		validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco::integer);
	end if;
	

		--Validacion si se mostraran todos los arcos
		if(p_id_arco='todos') then
			--Validacion que tipo de alertas se mostraran
			if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta 
					inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
				where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
					-- Se juntaron las consultas para traer los datos que sea advertencia e infomativo
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1';
			end if;
		elsif(validacion_arco>=1)then
		-- Validacion con ID de arco
			--Validacion que tipo de alertas se mostraran
			if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2';
			
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where cat.tipo_lector='1' and urr.placa = p_placa and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1';
			end if;
		end if;
	
END;
$$;
   DROP FUNCTION public.sp_consultar_lectura_vehiculo_placa(p_placa character varying, p_fecha_inicial timestamp without time zone, p_fecha_final timestamp without time zone, p_id_arco character varying, p_informativo integer, p_advertencia integer, p_critico integer);
       public       postgres    false    3    1            �            1255    103553 �   sp_consultar_lectura_vehiculo_tipo_vehiculo(timestamp without time zone, timestamp without time zone, character varying, integer, integer, integer, character varying, character varying)    FUNCTION     �@  CREATE FUNCTION public.sp_consultar_lectura_vehiculo_tipo_vehiculo(p_fecha_inicial timestamp without time zone, p_fecha_final timestamp without time zone, p_id_arco character varying, p_informativo integer, p_advertencia integer, p_critico integer, p_tipo_vehiculo character varying, p_color character varying) RETURNS TABLE(tipo_registro integer, fecha_hora timestamp without time zone, nombre_arco character varying, descripcion character varying, niv character varying, fuente_informacion character varying, placa character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_arco integer;
BEGIN

	if(p_id_arco='todos') then
		
	else
		validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco::integer);
	end if;
	

		--Validacion si se mostraran todos los arcos
		if(p_id_arco='todos') then
			--Validacion que tipo de alertas se mostraran
			if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta 
					inner join lector l on l.id_lector=al.fk_id_lector 
					left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
				where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
					-- Se juntaron las consultas para traer los datos que sea advertencia e infomativo
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and cat.tipo_registro='1';
			end if;
		elsif(validacion_arco>=1)then
		-- Validacion con ID de arco
			--Validacion que tipo de alertas se mostraran
			if(p_informativo=1 and p_advertencia=1 and p_critico=1)then
				-- Validacion si se mostraran las tres
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer;
			elsif(p_informativo=1 and p_advertencia=1 and p_critico=0)then
				-- Validacion menos critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1'
					union
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2';
			
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=1)then
				-- Validacion menos advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1'
					UNION
					select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=1)then
				-- Validacion menos informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2'
					UNION
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=0 and p_critico=1)then
				-- Validacion solo critico
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='3';
			elsif(p_informativo=0 and p_advertencia=1 and p_critico=0)then
				-- Validacion solo advertencia
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='2';
			elsif(p_informativo=1 and p_advertencia=0 and p_critico=0)then
				-- Validacion solo informativo
				return query
				select cat.tipo_registro as tipo_registro,al.fecha_hora as fecha_hora,l.nombre as nombre_arco,cat.nombre as descripcion, al.fk_id_objeto as niv, oa.nombre_corto as fuente_informacion, urr.placa as placa
					from alerta al inner join cat_alerta cat on al.fk_id_cat_alerta=cat.id_cat_alerta inner join lector l on l.id_lector=al.fk_id_lector left join origen_alerta oa on oa.id_origen_alerta=al.fk_id_origen_alerta
					inner join unidad_registro_repuve urr on urr.niv = al.fk_id_objeto
					where urr.clase_unidad=p_tipo_vehiculo and urr.color = p_color and cat.tipo_lector='1' and al.fecha_hora between p_fecha_inicial and p_fecha_final and l.id_lector=p_id_arco::integer and cat.tipo_registro='1';
			end if;
		end if;
	
END;
$$;
 6  DROP FUNCTION public.sp_consultar_lectura_vehiculo_tipo_vehiculo(p_fecha_inicial timestamp without time zone, p_fecha_final timestamp without time zone, p_id_arco character varying, p_informativo integer, p_advertencia integer, p_critico integer, p_tipo_vehiculo character varying, p_color character varying);
       public       postgres    false    1    3            �            1255    70778 *   sp_consultar_unidad_niv(character varying)    FUNCTION     k  CREATE FUNCTION public.sp_consultar_unidad_niv(p_niv character varying) RETURNS TABLE(tipo_vehiculo character varying, marca character varying, color character varying, placa character varying, niv character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_niv integer;
BEGIN

validacion_niv := (select count(urr.id_urr) from unidad_registro_repuve urr where urr.niv=p_niv);

	if(validacion_niv>=1)then
	return query
		select urr.clase_unidad as tipo_vehiculo, urr.marca as marca, urr.color as color, urr.placa as placa, urr.niv as niv from unidad_registro_repuve urr where urr.niv=p_niv;
	end if;

END;
$$;
 G   DROP FUNCTION public.sp_consultar_unidad_niv(p_niv character varying);
       public       postgres    false    1    3            �            1255    78964 ,   sp_consultar_unidad_placa(character varying)    FUNCTION     w  CREATE FUNCTION public.sp_consultar_unidad_placa(p_placa character varying) RETURNS TABLE(tipo_vehiculo character varying, marca character varying, color character varying, placa character varying, niv character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_niv integer;
BEGIN

validacion_niv := (select count(urr.id_urr) from unidad_registro_repuve urr where urr.placa=p_placa);

	if(validacion_niv>=1)then
	return query
		select urr.clase_unidad as tipo_vehiculo, urr.marca as marca, urr.color as color, urr.placa as placa, urr.niv as niv from unidad_registro_repuve urr where urr.placa=p_placa;
	end if;

END;
$$;
 K   DROP FUNCTION public.sp_consultar_unidad_placa(p_placa character varying);
       public       postgres    false    1    3            �            1255    62860 G   sp_registrar_alerta_arco(integer, integer, timestamp without time zone)    FUNCTION     	  CREATE FUNCTION public.sp_registrar_alerta_arco(p_id_arco integer, p_fk_id_cat_alerta integer, p_fecha_hora timestamp without time zone) RETURNS TABLE(codigo integer, respuesta character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_arco integer;
	declare validacion_fk_id_alerta integer;
BEGIN
validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_id_arco);
validacion_fk_id_alerta := (select count(al.id_cat_alerta) from cat_alerta al where al.id_cat_alerta=p_fk_id_cat_alerta);

if(validacion_fk_id_alerta>=1)then
	if(validacion_arco>=1)then
		insert into alerta(fecha_hora,fk_id_lector,fk_id_cat_alerta)
			values(p_fecha_hora,p_id_arco,p_fk_id_cat_alerta);
			return query
			select (001) as codigo, ('Operacion exitosa.')::character varying as respuesta;
	else
		return query
			select (00) as codigo, ('El arco no existe.')::character varying as respuesta;
	end if;
else
	return query
			select (001) as codigo, ('La alerta no existe')::character varying as respuesta;
end if;
END;
$$;
 �   DROP FUNCTION public.sp_registrar_alerta_arco(p_id_arco integer, p_fk_id_cat_alerta integer, p_fecha_hora timestamp without time zone);
       public       postgres    false    1    3            �            1255    62870 r   sp_registrar_lectura(character varying, character varying, character varying, integer, integer, character varying)    FUNCTION     v  CREATE FUNCTION public.sp_registrar_lectura(p_nci character varying, p_tid character varying, p_ubicacion character varying, p_fk_id_carril integer, p_fk_id_arco integer, p_fk_niv character varying) RETURNS TABLE(codigo integer, respuesta character varying)
    LANGUAGE plpgsql
    AS $$
	declare validacion_arco integer;
	declare validacion_carril integer;
BEGIN

validacion_arco := (select count(l.id_lector) from lector l where l.id_lector=p_fk_id_arco);
validacion_carril := (select count(ca.id_carril) from carril ca where ca.id_carril=p_fk_id_carril);

if(validacion_carril>=1)then
	if(validacion_arco>=1) then
		insert into lectura_chip_repuve (nci, tid, ubicacion, fk_id_carril, fk_id_arco, fk_niv, fecha_hora ) 
			values (p_nci, p_tid, p_ubicacion, p_fk_id_carril, p_fk_id_arco, p_fk_niv, now());
  		return query
  			select (001) as codigo, ('Operación exitosa.')::character varying as respuesta;
	else
		return query
			select (00) as codigo, ('El arco no existe.')::character varying as respuesta;
	end if;
else
	return query
		select (00) as codigo, ('El carril no existe.')::character varying as respuesta;
end if;
END;
$$;
 �   DROP FUNCTION public.sp_registrar_lectura(p_nci character varying, p_tid character varying, p_ubicacion character varying, p_fk_id_carril integer, p_fk_id_arco integer, p_fk_niv character varying);
       public       postgres    false    1    3            �            1255    62871 8   sp_validar_usuario(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.sp_validar_usuario(p_usuario character varying, p_contrasena character varying) RETURNS TABLE(codigo integer)
    LANGUAGE plpgsql
    AS $$
	declare validar_usuario integer;
BEGIN
validar_usuario := (select count(u.id_usuario) from usuario u where u.usuario=p_usuario and u.contrasena=p_contrasena);
	if(validar_usuario>=1)then
		return query--
		select (1) as codigo;
	else
		return query--
		select (0) as codigo;
	end if;
		
END;
$$;
 f   DROP FUNCTION public.sp_validar_usuario(p_usuario character varying, p_contrasena character varying);
       public       postgres    false    3    1            �            1259    62761 
   seq_alerta    SEQUENCE     s   CREATE SEQUENCE public.seq_alerta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.seq_alerta;
       public       postgres    false    3            �            1259    62763    alerta    TABLE     )  CREATE TABLE public.alerta (
    fecha_hora timestamp without time zone NOT NULL,
    fk_id_objeto character varying,
    fk_id_cat_alerta integer NOT NULL,
    fk_id_origen_alerta integer,
    id_alerta integer DEFAULT nextval('public.seq_alerta'::regclass) NOT NULL,
    fk_id_lector integer
);
    DROP TABLE public.alerta;
       public         postgres    false    214    3            �           0    0    TABLE alerta    COMMENT     h   COMMENT ON TABLE public.alerta IS 'Colección de datos que contiene los datos de registros de Alertas';
            public       postgres    false    215            �           0    0    COLUMN alerta.fecha_hora    COMMENT     h   COMMENT ON COLUMN public.alerta.fecha_hora IS 'Indica la fecha y la hora en que se generó la alerta.';
            public       postgres    false    215            �           0    0    COLUMN alerta.fk_id_objeto    COMMENT     �   COMMENT ON COLUMN public.alerta.fk_id_objeto IS 'Identificador del vehículo o placa del vehículo que generó la alerta o Identificador del Arco que generó la alerta por algún inconveniente con los dispositivos.';
            public       postgres    false    215            �           0    0    COLUMN alerta.fk_id_cat_alerta    COMMENT     d   COMMENT ON COLUMN public.alerta.fk_id_cat_alerta IS 'Número identificador de la tabla cat_alerta';
            public       postgres    false    215            �           0    0 !   COLUMN alerta.fk_id_origen_alerta    COMMENT     j   COMMENT ON COLUMN public.alerta.fk_id_origen_alerta IS 'Número identificador de la tabla Origen_Alerta';
            public       postgres    false    215            �           0    0    COLUMN alerta.id_alerta    COMMENT     Z   COMMENT ON COLUMN public.alerta.id_alerta IS 'Es el identificador único de cada alerta';
            public       postgres    false    215            �           0    0    COLUMN alerta.fk_id_lector    COMMENT     g   COMMENT ON COLUMN public.alerta.fk_id_lector IS 'Clave foranea que hace referencia a la tabla Lector';
            public       postgres    false    215            �            1259    62752    alerta_informacion_externa    TABLE     �   CREATE TABLE public.alerta_informacion_externa (
    id_alerta_externa integer DEFAULT nextval('public.alerta_informacion_externa'::regclass) NOT NULL,
    niv character varying,
    fk_id_origen_alerta integer,
    fk_id_cat_alerta integer
);
 .   DROP TABLE public.alerta_informacion_externa;
       public         postgres    false    3            �           0    0     TABLE alerta_informacion_externa    COMMENT     w   COMMENT ON TABLE public.alerta_informacion_externa IS 'Tabla que guardara la información de las consultas externas.';
            public       postgres    false    213            �           0    0 3   COLUMN alerta_informacion_externa.id_alerta_externa    COMMENT     n   COMMENT ON COLUMN public.alerta_informacion_externa.id_alerta_externa IS 'Número identificador de la tabla';
            public       postgres    false    213            �           0    0 %   COLUMN alerta_informacion_externa.niv    COMMENT     d   COMMENT ON COLUMN public.alerta_informacion_externa.niv IS 'Número de Identificación Vehícular';
            public       postgres    false    213            �           0    0 5   COLUMN alerta_informacion_externa.fk_id_origen_alerta    COMMENT     ~   COMMENT ON COLUMN public.alerta_informacion_externa.fk_id_origen_alerta IS 'Número identificador de la tabla Origen_Alerta';
            public       postgres    false    213            �           0    0 2   COLUMN alerta_informacion_externa.fk_id_cat_alerta    COMMENT     x   COMMENT ON COLUMN public.alerta_informacion_externa.fk_id_cat_alerta IS 'Número identificador de la tabla cat_alerta';
            public       postgres    false    213            �            1259    62610 
   seq_antena    SEQUENCE     s   CREATE SEQUENCE public.seq_antena
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.seq_antena;
       public       postgres    false    3            �            1259    62636    antena    TABLE     �   CREATE TABLE public.antena (
    id_antena integer DEFAULT nextval('public.seq_antena'::regclass) NOT NULL,
    fk_id_arco integer
);
    DROP TABLE public.antena;
       public         postgres    false    199    3            �           0    0    TABLE antena    COMMENT     X   COMMENT ON TABLE public.antena IS 'Colección de datos que contiene todas las antenas';
            public       postgres    false    201            �           0    0    COLUMN antena.id_antena    COMMENT     R   COMMENT ON COLUMN public.antena.id_antena IS 'Número identificador de la tabla';
            public       postgres    false    201            �           0    0    COLUMN antena.fk_id_arco    COMMENT     b   COMMENT ON COLUMN public.antena.fk_id_arco IS 'Número de identificación a que arco pertenece.';
            public       postgres    false    201            �            1259    62649 
   seq_carril    SEQUENCE     s   CREATE SEQUENCE public.seq_carril
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.seq_carril;
       public       postgres    false    3            �            1259    62651    carril    TABLE     �   CREATE TABLE public.carril (
    id_carril integer DEFAULT nextval('public.seq_carril'::regclass) NOT NULL,
    orientacion character varying NOT NULL,
    fk_id_antena integer
);
    DROP TABLE public.carril;
       public         postgres    false    203    3            �           0    0    TABLE carril    COMMENT     m   COMMENT ON TABLE public.carril IS 'Colección de datos que contiene los carriles y a que antena pertenece.';
            public       postgres    false    204            �           0    0    COLUMN carril.id_carril    COMMENT     Y   COMMENT ON COLUMN public.carril.id_carril IS 'Número identificador de la tabla Carril';
            public       postgres    false    204            �           0    0    COLUMN carril.orientacion    COMMENT     �   COMMENT ON COLUMN public.carril.orientacion IS 'Orientación del  flujo vehícular del carril. Los probables valores pueden ser:NS, SN, WE, EW, NE-SW, SW-NE, NW-SE, SE_NW, BiDir.';
            public       postgres    false    204            �           0    0    COLUMN carril.fk_id_antena    COMMENT     j   COMMENT ON COLUMN public.carril.fk_id_antena IS 'Número identificador a que carril pertenece la antena';
            public       postgres    false    204            �            1259    62725    seq_cat_alerta    SEQUENCE     w   CREATE SEQUENCE public.seq_cat_alerta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.seq_cat_alerta;
       public       postgres    false    3            �            1259    62727 
   cat_alerta    TABLE     �   CREATE TABLE public.cat_alerta (
    id_cat_alerta integer DEFAULT nextval('public.seq_cat_alerta'::regclass) NOT NULL,
    nombre character varying NOT NULL,
    tipo_registro integer,
    tipo_lector integer
);
    DROP TABLE public.cat_alerta;
       public         postgres    false    208    3            �           0    0    TABLE cat_alerta    COMMENT     `   COMMENT ON TABLE public.cat_alerta IS 'Colección de datos que contiene los tipos de alertas.';
            public       postgres    false    209            �           0    0    COLUMN cat_alerta.id_cat_alerta    COMMENT     a   COMMENT ON COLUMN public.cat_alerta.id_cat_alerta IS 'Número identificador de la tabla alerta';
            public       postgres    false    209            �           0    0    COLUMN cat_alerta.nombre    COMMENT     O   COMMENT ON COLUMN public.cat_alerta.nombre IS 'Nombre de la alerta ingresada';
            public       postgres    false    209            �           0    0    COLUMN cat_alerta.tipo_registro    COMMENT     d   COMMENT ON COLUMN public.cat_alerta.tipo_registro IS '1 = Informativo
2 = Advertencia
3 = Critico';
            public       postgres    false    209            �           0    0    COLUMN cat_alerta.tipo_lector    COMMENT     N   COMMENT ON COLUMN public.cat_alerta.tipo_lector IS '0 = Arco.
1 = Vehiculo.';
            public       postgres    false    209            �            1259    62590    seq_arco    SEQUENCE     q   CREATE SEQUENCE public.seq_arco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.seq_arco;
       public       postgres    false    3            �            1259    62627    lector    TABLE     -  CREATE TABLE public.lector (
    id_lector integer DEFAULT nextval('public.seq_arco'::regclass) NOT NULL,
    nombre character varying NOT NULL,
    tipo bit(1) NOT NULL,
    ubicacion character varying NOT NULL,
    descripcion character varying NOT NULL,
    rutas_logs character varying NOT NULL,
    enlace_servidor character varying NOT NULL,
    frecuencia_de_sincronizacion integer NOT NULL,
    enlace_impinj character varying NOT NULL,
    fecha_reporte timestamp without time zone NOT NULL,
    tipo_lector integer NOT NULL,
    estado integer
);
    DROP TABLE public.lector;
       public         postgres    false    197    3            �           0    0    TABLE lector    COMMENT     p   COMMENT ON TABLE public.lector IS 'Colección de datos para el almacenamiento de los parámetros de un Lector';
            public       postgres    false    200            �           0    0    COLUMN lector.id_lector    COMMENT     U   COMMENT ON COLUMN public.lector.id_lector IS 'Número de Identificación de Lector';
            public       postgres    false    200            �           0    0    COLUMN lector.nombre    COMMENT     E   COMMENT ON COLUMN public.lector.nombre IS 'Nombre Asignado al Arco';
            public       postgres    false    200            �           0    0    COLUMN lector.tipo    COMMENT     m   COMMENT ON COLUMN public.lector.tipo IS 'Permite identificar si el arco es fijo o móvil
1=Fijo, 0= Móvil';
            public       postgres    false    200            �           0    0    COLUMN lector.ubicacion    COMMENT     s   COMMENT ON COLUMN public.lector.ubicacion IS 'Coordenadas de la ubicación de arco P ej. 19.2555374,-103.7365229';
            public       postgres    false    200            �           0    0    COLUMN lector.descripcion    COMMENT     �   COMMENT ON COLUMN public.lector.descripcion IS 'Descripción del Arco, comúnmente se describe la ubicación conocida del arco P ej. Arco Ubicado en la autopista Manzanillo - Guadalajara KM 33.7, de poniente a oriente.';
            public       postgres    false    200            �           0    0    COLUMN lector.rutas_logs    COMMENT     �   COMMENT ON COLUMN public.lector.rutas_logs IS 'Ruta de la carpeta que almacena los archivos de Log de Errores que ocurren en las aplicaciones del Arco';
            public       postgres    false    200            �           0    0    COLUMN lector.enlace_servidor    COMMENT     c   COMMENT ON COLUMN public.lector.enlace_servidor IS 'IP o ruta de red para conectarse al Servidor';
            public       postgres    false    200            �           0    0 *   COLUMN lector.frecuencia_de_sincronizacion    COMMENT     �   COMMENT ON COLUMN public.lector.frecuencia_de_sincronizacion IS 'Cantidad de segundos en los que la aplicación Agente de sincronización estará tratando de sincronizar las lecturas que no fue posible sincronizar cuando fueron registradas';
            public       postgres    false    200            �           0    0    COLUMN lector.enlace_impinj    COMMENT     d   COMMENT ON COLUMN public.lector.enlace_impinj IS 'IP o ruta de red para conectarse al lector RFID';
            public       postgres    false    200            �           0    0    COLUMN lector.tipo_lector    COMMENT     i   COMMENT ON COLUMN public.lector.tipo_lector IS '1 = Arco
2 = Semaforo inteligente
3 = Punto de control';
            public       postgres    false    200            �            1259    62647    seq_lectura    SEQUENCE     t   CREATE SEQUENCE public.seq_lectura
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.seq_lectura;
       public       postgres    false    3            �            1259    62716    lectura_chip_repuve    TABLE     �  CREATE TABLE public.lectura_chip_repuve (
    id_lectura integer DEFAULT nextval('public.seq_lectura'::regclass) NOT NULL,
    nci character varying NOT NULL,
    tid character varying NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    ubicacion character varying,
    fk_niv character varying NOT NULL,
    fk_id_carril integer NOT NULL,
    fk_id_arco integer NOT NULL
);
 '   DROP TABLE public.lectura_chip_repuve;
       public         postgres    false    202    3            �           0    0    TABLE lectura_chip_repuve    COMMENT     t   COMMENT ON TABLE public.lectura_chip_repuve IS 'Colección de datos que contiene el registro al pasar por un arco';
            public       postgres    false    207            �           0    0 %   COLUMN lectura_chip_repuve.id_lectura    COMMENT     h   COMMENT ON COLUMN public.lectura_chip_repuve.id_lectura IS 'Número identificador de la tabla Lectura';
            public       postgres    false    207            �           0    0    COLUMN lectura_chip_repuve.nci    COMMENT     ]   COMMENT ON COLUMN public.lectura_chip_repuve.nci IS 'Número de Constancia de Inscripción';
            public       postgres    false    207            �           0    0    COLUMN lectura_chip_repuve.tid    COMMENT     �   COMMENT ON COLUMN public.lectura_chip_repuve.tid IS 'Número de Identificación del Dispositivo Electrónico / (TAG ID) / número de etiqueta de Chip de RFID de REPUVE';
            public       postgres    false    207            �           0    0 %   COLUMN lectura_chip_repuve.fecha_hora    COMMENT     c   COMMENT ON COLUMN public.lectura_chip_repuve.fecha_hora IS 'Fecha y hora detallada de la lectura';
            public       postgres    false    207            �           0    0 $   COLUMN lectura_chip_repuve.ubicacion    COMMENT     h   COMMENT ON COLUMN public.lectura_chip_repuve.ubicacion IS 'Ubicación de donde se registro la lectura';
            public       postgres    false    207            �           0    0 !   COLUMN lectura_chip_repuve.fk_niv    COMMENT     `   COMMENT ON COLUMN public.lectura_chip_repuve.fk_niv IS 'Número de Identificación Vehícular';
            public       postgres    false    207            �           0    0 '   COLUMN lectura_chip_repuve.fk_id_carril    COMMENT     �   COMMENT ON COLUMN public.lectura_chip_repuve.fk_id_carril IS 'Número de identificador del carril donde se llevo a cabo la lectura';
            public       postgres    false    207            �           0    0 %   COLUMN lectura_chip_repuve.fk_id_arco    COMMENT     ~   COMMENT ON COLUMN public.lectura_chip_repuve.fk_id_arco IS 'Número identificador del arco donde se llevo a cabo la lectura';
            public       postgres    false    207            �            1259    62736    seq_origen_alerta    SEQUENCE     z   CREATE SEQUENCE public.seq_origen_alerta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.seq_origen_alerta;
       public       postgres    false    3            �            1259    62741    origen_alerta    TABLE     �   CREATE TABLE public.origen_alerta (
    id_origen_alerta integer DEFAULT nextval('public.seq_origen_alerta'::regclass) NOT NULL,
    nombre_corto character varying NOT NULL,
    nombre_largo character varying,
    accesodatos bit(1)
);
 !   DROP TABLE public.origen_alerta;
       public         postgres    false    210    3            �           0    0    TABLE origen_alerta    COMMENT     b   COMMENT ON TABLE public.origen_alerta IS 'Colección de datos que contiene las alertas externas';
            public       postgres    false    211            �           0    0 %   COLUMN origen_alerta.id_origen_alerta    COMMENT     n   COMMENT ON COLUMN public.origen_alerta.id_origen_alerta IS 'Número identificador de la tabla Origen Alerta';
            public       postgres    false    211            �           0    0 !   COLUMN origen_alerta.nombre_corto    COMMENT     �   COMMENT ON COLUMN public.origen_alerta.nombre_corto IS 'Nombre corto de la base de datos. 
Pj:
 BD REPUVE ESTATAL
 BD REPUVE NACIONAL
 BD IPH
 BD SIVEBU';
            public       postgres    false    211            �           0    0 !   COLUMN origen_alerta.nombre_largo    COMMENT     �  COMMENT ON COLUMN public.origen_alerta.nombre_largo IS 'Descripcion de la fuente externa.
Pj:
-Base de Datos del Registro Público Vehicular Estatal
-Base de Datos del Registro Público Vehicular Nacional
-Base de Datos de la Fiscalía General del Estado (antes Procuraduría General de Justicia)
-Base de Datos referente al Informe Policial Homologado
-Base de Datos del Sistema de Vehículos Buscados';
            public       postgres    false    211            �           0    0     COLUMN origen_alerta.accesodatos    COMMENT     }   COMMENT ON COLUMN public.origen_alerta.accesodatos IS 'Validación si existe un error de acceso de datos.
0 = Error
1 = Ok';
            public       postgres    false    211            �            1259    62750    seq_alerta_informacion_externa    SEQUENCE     �   CREATE SEQUENCE public.seq_alerta_informacion_externa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.seq_alerta_informacion_externa;
       public       postgres    false    3            �            1259    62808    seq_error_arco    SEQUENCE     w   CREATE SEQUENCE public.seq_error_arco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.seq_error_arco;
       public       postgres    false    3            �            1259    62824    seq_incidente_vehiculo    SEQUENCE        CREATE SEQUENCE public.seq_incidente_vehiculo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.seq_incidente_vehiculo;
       public       postgres    false    3            �            1259    62665    seq_unidad_registro_repuve    SEQUENCE     �   CREATE SEQUENCE public.seq_unidad_registro_repuve
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.seq_unidad_registro_repuve;
       public       postgres    false    3            �            1259    62582    seq_usuario    SEQUENCE     t   CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.seq_usuario;
       public       postgres    false    3            �            1259    62698    unidad_registro_repuve    TABLE     �  CREATE TABLE public.unidad_registro_repuve (
    id_urr integer DEFAULT nextval('public.seq_unidad_registro_repuve'::regclass) NOT NULL,
    niv character varying NOT NULL,
    placa_rfid character varying NOT NULL,
    clase_unidad character varying NOT NULL,
    marca character varying NOT NULL,
    submarca character varying,
    color character varying,
    no_motor character varying NOT NULL,
    tipo character varying NOT NULL,
    placa character varying NOT NULL
);
 *   DROP TABLE public.unidad_registro_repuve;
       public         postgres    false    205    3            �           0    0    TABLE unidad_registro_repuve    COMMENT     �   COMMENT ON TABLE public.unidad_registro_repuve IS 'Colección de datos que REPUVE tiene de todos los vehículos Mexicanos que portan el Chip RFID de REPUVE';
            public       postgres    false    206            �           0    0 $   COLUMN unidad_registro_repuve.id_urr    COMMENT     c   COMMENT ON COLUMN public.unidad_registro_repuve.id_urr IS 'Número identificador de las unidades';
            public       postgres    false    206            �           0    0 !   COLUMN unidad_registro_repuve.niv    COMMENT     �   COMMENT ON COLUMN public.unidad_registro_repuve.niv IS 'Número de Identificación vehicular el cual se obtiene de la lectura del chip RFID. ';
            public       postgres    false    206            �           0    0 (   COLUMN unidad_registro_repuve.placa_rfid    COMMENT     �   COMMENT ON COLUMN public.unidad_registro_repuve.placa_rfid IS 'Número de placa que se obtiene de la lectura del chip RFID de REPUVE.';
            public       postgres    false    206            �           0    0 *   COLUMN unidad_registro_repuve.clase_unidad    COMMENT     |   COMMENT ON COLUMN public.unidad_registro_repuve.clase_unidad IS 'Motocicleta, Motocarro, Camioneta, Carro, Camión, Etc. ';
            public       postgres    false    206            �           0    0 #   COLUMN unidad_registro_repuve.marca    COMMENT     �   COMMENT ON COLUMN public.unidad_registro_repuve.marca IS 'Nombre descriptivo que le pertenece el vehículo. Ejemplo: Toyota, Nissan, Renault, Etc.';
            public       postgres    false    206            �           0    0 &   COLUMN unidad_registro_repuve.submarca    COMMENT     �   COMMENT ON COLUMN public.unidad_registro_repuve.submarca IS 'Nombre descriptivo del Modelo al que pertenece el vehículo. Ejemplo: Sienna, NP300, Logan, Etc.';
            public       postgres    false    206            �           0    0 #   COLUMN unidad_registro_repuve.color    COMMENT     Q   COMMENT ON COLUMN public.unidad_registro_repuve.color IS 'Color del vehículo.';
            public       postgres    false    206            �           0    0 &   COLUMN unidad_registro_repuve.no_motor    COMMENT     �   COMMENT ON COLUMN public.unidad_registro_repuve.no_motor IS 'Identificación alfanumérica que identifica al motor que porta el vehículo.';
            public       postgres    false    206            �           0    0 "   COLUMN unidad_registro_repuve.tipo    COMMENT     g   COMMENT ON COLUMN public.unidad_registro_repuve.tipo IS 'Auto, Suvs, Pick-up, Rodado sencillo, Etc. ';
            public       postgres    false    206            �           0    0 #   COLUMN unidad_registro_repuve.placa    COMMENT     O   COMMENT ON COLUMN public.unidad_registro_repuve.placa IS 'Placa del vehiculo';
            public       postgres    false    206            �            1259    62592    usuario    TABLE     �   CREATE TABLE public.usuario (
    id_usuario integer DEFAULT nextval('public.seq_usuario'::regclass) NOT NULL,
    usuario character varying NOT NULL,
    contrasena character varying NOT NULL
);
    DROP TABLE public.usuario;
       public         postgres    false    196    3            �           0    0    TABLE usuario    COMMENT     D   COMMENT ON TABLE public.usuario IS 'Tabla para registrar usuarios';
            public       postgres    false    198            �           0    0    COLUMN usuario.id_usuario    COMMENT     \   COMMENT ON COLUMN public.usuario.id_usuario IS 'Número identificador de la tabla usuario';
            public       postgres    false    198            �           0    0    COLUMN usuario.usuario    COMMENT     C   COMMENT ON COLUMN public.usuario.usuario IS 'Usuario del cliente';
            public       postgres    false    198            �           0    0    COLUMN usuario.contrasena    COMMENT     J   COMMENT ON COLUMN public.usuario.contrasena IS 'Contraseña del cliente';
            public       postgres    false    198            u          0    62763    alerta 
   TABLE DATA               z   COPY public.alerta (fecha_hora, fk_id_objeto, fk_id_cat_alerta, fk_id_origen_alerta, id_alerta, fk_id_lector) FROM stdin;
    public       postgres    false    215   չ      s          0    62752    alerta_informacion_externa 
   TABLE DATA               s   COPY public.alerta_informacion_externa (id_alerta_externa, niv, fk_id_origen_alerta, fk_id_cat_alerta) FROM stdin;
    public       postgres    false    213   h�      g          0    62636    antena 
   TABLE DATA               7   COPY public.antena (id_antena, fk_id_arco) FROM stdin;
    public       postgres    false    201   ��      j          0    62651    carril 
   TABLE DATA               F   COPY public.carril (id_carril, orientacion, fk_id_antena) FROM stdin;
    public       postgres    false    204   ��      o          0    62727 
   cat_alerta 
   TABLE DATA               W   COPY public.cat_alerta (id_cat_alerta, nombre, tipo_registro, tipo_lector) FROM stdin;
    public       postgres    false    209   ˺      f          0    62627    lector 
   TABLE DATA               �   COPY public.lector (id_lector, nombre, tipo, ubicacion, descripcion, rutas_logs, enlace_servidor, frecuencia_de_sincronizacion, enlace_impinj, fecha_reporte, tipo_lector, estado) FROM stdin;
    public       postgres    false    200   o�      m          0    62716    lectura_chip_repuve 
   TABLE DATA               |   COPY public.lectura_chip_repuve (id_lectura, nci, tid, fecha_hora, ubicacion, fk_niv, fk_id_carril, fk_id_arco) FROM stdin;
    public       postgres    false    207   ��      q          0    62741    origen_alerta 
   TABLE DATA               b   COPY public.origen_alerta (id_origen_alerta, nombre_corto, nombre_largo, accesodatos) FROM stdin;
    public       postgres    false    211   ��      l          0    62698    unidad_registro_repuve 
   TABLE DATA               �   COPY public.unidad_registro_repuve (id_urr, niv, placa_rfid, clase_unidad, marca, submarca, color, no_motor, tipo, placa) FROM stdin;
    public       postgres    false    206   ��      d          0    62592    usuario 
   TABLE DATA               B   COPY public.usuario (id_usuario, usuario, contrasena) FROM stdin;
    public       postgres    false    198   ]�      �           0    0 
   seq_alerta    SEQUENCE SET     9   SELECT pg_catalog.setval('public.seq_alerta', 25, true);
            public       postgres    false    214            �           0    0    seq_alerta_informacion_externa    SEQUENCE SET     M   SELECT pg_catalog.setval('public.seq_alerta_informacion_externa', 1, false);
            public       postgres    false    212            �           0    0 
   seq_antena    SEQUENCE SET     8   SELECT pg_catalog.setval('public.seq_antena', 1, true);
            public       postgres    false    199            �           0    0    seq_arco    SEQUENCE SET     6   SELECT pg_catalog.setval('public.seq_arco', 1, true);
            public       postgres    false    197            �           0    0 
   seq_carril    SEQUENCE SET     8   SELECT pg_catalog.setval('public.seq_carril', 1, true);
            public       postgres    false    203            �           0    0    seq_cat_alerta    SEQUENCE SET     =   SELECT pg_catalog.setval('public.seq_cat_alerta', 12, true);
            public       postgres    false    208            �           0    0    seq_error_arco    SEQUENCE SET     <   SELECT pg_catalog.setval('public.seq_error_arco', 6, true);
            public       postgres    false    216            �           0    0    seq_incidente_vehiculo    SEQUENCE SET     D   SELECT pg_catalog.setval('public.seq_incidente_vehiculo', 1, true);
            public       postgres    false    217            �           0    0    seq_lectura    SEQUENCE SET     :   SELECT pg_catalog.setval('public.seq_lectura', 17, true);
            public       postgres    false    202            �           0    0    seq_origen_alerta    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.seq_origen_alerta', 5, true);
            public       postgres    false    210            �           0    0    seq_unidad_registro_repuve    SEQUENCE SET     H   SELECT pg_catalog.setval('public.seq_unidad_registro_repuve', 3, true);
            public       postgres    false    205            �           0    0    seq_usuario    SEQUENCE SET     :   SELECT pg_catalog.setval('public.seq_usuario', 11, true);
            public       postgres    false    196            �
           2606    62760 :   alerta_informacion_externa alerta_informacion_externa_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.alerta_informacion_externa
    ADD CONSTRAINT alerta_informacion_externa_pkey PRIMARY KEY (id_alerta_externa);
 d   ALTER TABLE ONLY public.alerta_informacion_externa DROP CONSTRAINT alerta_informacion_externa_pkey;
       public         postgres    false    213            �
           2606    62800    alerta alerta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.alerta
    ADD CONSTRAINT alerta_pkey PRIMARY KEY (id_alerta);
 <   ALTER TABLE ONLY public.alerta DROP CONSTRAINT alerta_pkey;
       public         postgres    false    215            �
           2606    62641    antena antena_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.antena
    ADD CONSTRAINT antena_pkey PRIMARY KEY (id_antena);
 <   ALTER TABLE ONLY public.antena DROP CONSTRAINT antena_pkey;
       public         postgres    false    201            �
           2606    62635    lector arco_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.lector
    ADD CONSTRAINT arco_pkey PRIMARY KEY (id_lector);
 :   ALTER TABLE ONLY public.lector DROP CONSTRAINT arco_pkey;
       public         postgres    false    200            �
           2606    62659    carril carril_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.carril
    ADD CONSTRAINT carril_pkey PRIMARY KEY (id_carril);
 <   ALTER TABLE ONLY public.carril DROP CONSTRAINT carril_pkey;
       public         postgres    false    204            �
           2606    62735    cat_alerta cat_alerta_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.cat_alerta
    ADD CONSTRAINT cat_alerta_pkey PRIMARY KEY (id_cat_alerta);
 D   ALTER TABLE ONLY public.cat_alerta DROP CONSTRAINT cat_alerta_pkey;
       public         postgres    false    209            �
           2606    62724     lectura_chip_repuve lectura_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.lectura_chip_repuve
    ADD CONSTRAINT lectura_pkey PRIMARY KEY (id_lectura);
 J   ALTER TABLE ONLY public.lectura_chip_repuve DROP CONSTRAINT lectura_pkey;
       public         postgres    false    207            �
           2606    62749     origen_alerta origen_alerta_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.origen_alerta
    ADD CONSTRAINT origen_alerta_pkey PRIMARY KEY (id_origen_alerta);
 J   ALTER TABLE ONLY public.origen_alerta DROP CONSTRAINT origen_alerta_pkey;
       public         postgres    false    211            �
           2606    62706 2   unidad_registro_repuve unidad_registro_repuve_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.unidad_registro_repuve
    ADD CONSTRAINT unidad_registro_repuve_pkey PRIMARY KEY (id_urr);
 \   ALTER TABLE ONLY public.unidad_registro_repuve DROP CONSTRAINT unidad_registro_repuve_pkey;
       public         postgres    false    206            �
           2606    62852    usuario uq_usuario 
   CONSTRAINT     P   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uq_usuario UNIQUE (usuario);
 <   ALTER TABLE ONLY public.usuario DROP CONSTRAINT uq_usuario;
       public         postgres    false    198            �
           2606    62600    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    198            �
           2606    62769     alerta alerta_id_cat_alerta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.alerta
    ADD CONSTRAINT alerta_id_cat_alerta_fkey FOREIGN KEY (fk_id_cat_alerta) REFERENCES public.cat_alerta(id_cat_alerta);
 J   ALTER TABLE ONLY public.alerta DROP CONSTRAINT alerta_id_cat_alerta_fkey;
       public       postgres    false    215    209    2782            �
           2606    62774 #   alerta alerta_id_origen_alerta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.alerta
    ADD CONSTRAINT alerta_id_origen_alerta_fkey FOREIGN KEY (fk_id_origen_alerta) REFERENCES public.origen_alerta(id_origen_alerta);
 M   ALTER TABLE ONLY public.alerta DROP CONSTRAINT alerta_id_origen_alerta_fkey;
       public       postgres    false    215    211    2784            �
           2606    62642    antena antena_id_arco_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.antena
    ADD CONSTRAINT antena_id_arco_fkey FOREIGN KEY (fk_id_arco) REFERENCES public.lector(id_lector);
 D   ALTER TABLE ONLY public.antena DROP CONSTRAINT antena_id_arco_fkey;
       public       postgres    false    201    2772    200            �
           2606    62660    carril carril_id_antena_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carril
    ADD CONSTRAINT carril_id_antena_fkey FOREIGN KEY (fk_id_antena) REFERENCES public.antena(id_antena);
 F   ALTER TABLE ONLY public.carril DROP CONSTRAINT carril_id_antena_fkey;
       public       postgres    false    204    201    2774            u   �   x����!г��@��&�"R�6�K�[�+%R��d��~���5��Ṩ7��P\�'�V?1e�6��tU���rب���S���P��$.����x��
W�و��~�!��}7;      s      x������ � �      g      x�3�4����� ]      j      x�3�w�4����� !      o   �   x�e�A
�@EדS�	d�u��+��&f"��d�.<�Q�.�@B�K�}����±U!��D�*!����,����Q��xw	��y��ƫ�:.d�K���8��й{�\��[�{ٻ�S8��A�Gd�������r/�[~�`��E=E�      f   v   x��A
� F��x
Pu�1V��ޢ�R�I�_˷}�@�Q�M����*m��F�>���(c�����U�γ'7�gv���D��g�#z�-�J��04��>�h#�A�SO������      m   �   x���=�0��99E@#���lpƪK%�OP$������u� �C��[ ˼.�چ²"&��0��U��4��%���2�$������Ȁ>!O	ٕ�%/K��/{�d�1ĚE�����	ؖl�m��$)F;���F>��J��Po([w�Ĺ���7?�[.����Q���      q   �   x���;n�0�g�ӥ@�� v�&
W�O]X�I�&�Ǳr���X�L}-����\��J{�;T�깨1k�dp����3����Y��ӻ5ɡ"FtŲ���j������Ecy����kzU��t���R��"�\�_e\ov�XpOVrn� lh"���̟�"ОM�8$�=��5o��>�4z���Ӊ<�i���@�˘�-���,]bx�-���4      l   �   x�U��
�0Dϛ��ٽx�X���Q�����6�4������6o��0���5w��A�h�?��oz3�x��@��I��X8_���?����
�MB�y(��R����@m?�l�HٴbR{ъ��8ܢs���'��Z��T���R?�?�      d   ?   x�3�,-.M,��7�442615�2��qrå�a�fp!#��9B�&fh�Y��4"F��� �     