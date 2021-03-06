--@Autores:Chavira Tapia Andrés Uriel
--          Joya Venegas Jehosua Alan
--@Fecha    18/06/2020
--@Descripcion  Instrucciones DDL para crear tablas e índices con base en el modelo relacional elaborado, así mismo se ponen 
--las tablas en modo nologgin para evitar datos redo


-- 
-- table: actividad 
--
conn u_obj/u_obj

create table actividad(
    actividad_id             number(10, 0)    not null,
    descripcion              varchar2(40)     not null,
    constraint actividad_pk primary key (actividad_id)
    using index (
        create unique index actividad_pk on actividad(actividad_id)
        tablespace indices_tbs)
)tablespace objetos_tbs
;



-- 
-- table: pais 
--
disc
conn u_usr/u_usr

create table pais(
    pais_id        number(10, 0)    not null,
    clave          char(2)          not null
        constraint pais_clave_uk unique,
    nombre         varchar2(40)     not null,
    constraint pais_pk primary key (pais_id)
    using index (
        create unique index pais_pk on pais(pais_id)
        tablespace indices_tbs
    )
)tablespace compradores_tbs
;



-- 
-- table: comprador 
--

create table comprador(
    comprador_id          number(10, 0)    not null,
    nombre                varchar2(20)     not null,
    apellido_paterno      varchar2(20)     not null,
    apellido_materno      varchar2(20),
    correo_electronico    varchar2(40)     not null,
    foto_perfil           blob,
    resenia               varchar2(40)     not null,
    usuario               varchar2(20)     not null
        constraint comprador_usuario_uk unique,
    rfc                   varchar2(13)     not null
        constraint comprador_rfc_uk unique,
    direccion             varchar2(40)     not null,
    pais_id               number(10, 0)    not null,
    aval_id               number(10, 0),
    constraint comprador_pk primary key (comprador_id)
    using index (
        create unique index comprador_pk on comprador(comprador_id)
        tablespace indices_tbs
    ), 
    constraint comprador_pais_id_fk foreign key (pais_id)
    references pais(pais_id),
    constraint comprador_aval_id_fk foreign key (aval_id)
    references comprador(comprador_id)
)LOB(foto_perfil) store as basicfile(tablespace indices_blob_tbs)
tablespace compradores_tbs
;



-- 
-- table: subasta 
--

create table subasta(
    subasta_id              number(10, 0)    not null,
    fecha                   date             not null,
    direccion_internet      varchar2(40)     not null,
    recaduacion_estimada    number(10, 0)    not null,
    recaudacion             number(10, 0),
    constraint subasta_pk primary key (subasta_id)
    using index (
        create unique index subasta_pk on subasta(subasta_id)
        tablespace indices_tbs
    )
)tablespace subastas_tbs
;



-- 
-- table: status_objeto 
--
disc
conn u_obj/u_obj

create table status_objeto(
    status_objeto_id    number(10, 0)    not null,
    clave               char(4)          not null,
    descripcion         varchar2(40)     not null,
    constraint status_objeto_pk primary key (status_objeto_id)
    using index (
        create unique index status_objeto_pk on status_objeto(status_objeto_id)
        tablespace indices_tbs
    )
)tablespace historico_tbs
;



-- 
-- table: objeto 
--
disc
conn sys/system2 as sysdba
grant references on u_usr.comprador to u_obj;
grant references on u_usr.subasta to u_obj;
disc
conn u_obj/u_obj

create table objeto(
    objeto_id                number(10, 0)    not null,
    nombre                   varchar2(40)     not null,
    descripcion              varchar2(40)     not null,
    precio_inicial           number(12, 0)    not null,
    codigo_barras            number(14, 0)    not null
        constraint objeto_codigo_barras unique,
    fecha_status             date             not null,
    tipo_objeto              char(1)          not null,
    propietario_objeto_id    number(10, 0),
    subasta_id               number(10, 0)    not null,
    status_objeto_id         number(10, 0)    not null,
    constraint objeto_pk primary key (objeto_id)
    using index (
        create unique index objeto_pk on objeto(objeto_id)
        tablespace indices_tbs
    ), 
    constraint objeto_propietario_objeto_id_fk foreign key (propietario_objeto_id)
    references u_usr.comprador(comprador_id),
    constraint objeto_subasta_id_fk foreign key (subasta_id)
    references u_usr.subasta(subasta_id),
    constraint objeto_status_objeto_id_fk foreign key (status_objeto_id)
    references status_objeto(status_objeto_id),
    constraint objeto_tipo_objeto_ck check (tipo_objeto IN('1','2','3'))
)tablespace objetos_tbs
;



-- 
-- table: hacienda 
--

create table hacienda(
    objeto_id             number(10, 0)    not null,
    nombre                varchar2(40)     not null,
    extension_km_2        number(10, 2)    not null,
    direccion             varchar2(40)     not null,
    constraint hacienda_pk primary key (objeto_id)
    using index (
        create unique index hacienda_pk on hacienda(objeto_id)
        tablespace indices_tbs
    ), 
    constraint hacienda_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)tablespace objetos_tbs
;



-- 
-- table: actividad_hacienda 
--

create table actividad_hacienda(
    objeto_id       number(10, 0)    not null,
    actividad_id    number(10, 0)    not null,
    constraint actividad_hacienda_pk primary key (objeto_id, actividad_id)
    using index (
        create unique index actividad_hacienda_pk on actividad_hacienda(objeto_id, actividad_id)
        tablespace indices_tbs
    ), 
    constraint actividad_hacienda_actividad_id_fk foreign key (actividad_id)
    references actividad(actividad_id),
    constraint actividad_hacienda_objeto_id_fk foreign key (objeto_id)
    references hacienda(objeto_id)
)tablespace objetos_tbs
;



-- 
-- table: marca 
--

create table marca(
    marca_id        number(10, 0)    not null,
    nombre          varchar2(40)     not null,
    constraint marca_pk primary key (marca_id)
    using index (
        create unique index marca_pk on marca(marca_id)
        tablespace indices_tbs
    )
)tablespace objetos_tbs
;



-- 
-- table: modelo 
--

create table modelo(
    modelo_id        number(10, 0)    not null,
    nombre           varchar2(40)     not null,
    marca_id         number(10, 0)    not null,
    constraint modelo_pk primary key (modelo_id)
    using index (
        create unique index modelo_pk on modelo(modelo_id)
        tablespace indices_tbs
    ), 
    constraint modelo_marca_id_fk foreign key (marca_id)
    references marca(marca_id)
)tablespace objetos_tbs
;



-- 
-- table: auto 
--

create table auto(
    objeto_id       number(10, 0)    not null,
    anio            number(4, 0)     not null,
    num_serie       varchar2(40)     not null,
    no_cilindros    number(2, 0)     not null,
    modelo_id       number(10, 0)    not null,
    constraint auto_pk primary key (objeto_id)
    using index (
        create unique index auto_pk on auto(objeto_id)
        tablespace indices_tbs
    ), 
    constraint auto_modelo_id_fk foreign key (modelo_id)
    references modelo(modelo_id),
    constraint auto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)tablespace objetos_tbs
;



-- 
-- table: banco 
--
disc
conn u_usr/u_usr

create table banco(
    banco_id             number(10, 0)    not null,
    clave                char(4)          not null
        constraint banco_clave_uk unique,
    descripcion          varchar2(40)     not null,
    nombre               varchar2(40)     not null,
    constraint banco_pk primary key (banco_id)
    using index (
        create unique index banco_pk on banco(banco_id)
        tablespace indices_tbs
    )
)tablespace compradores_tbs
;



-- 
-- table: casa 
--
disc
conn u_obj/u_obj

create table casa(
    objeto_id          number(10, 0)    not null,
    latitud            number(4, 2)     not null,
    longitud           number(4, 2)     not null,
    direccion          varchar2(40)     not null,
    caracteristicas    varchar2(40)     not null,
    constraint casa_pk primary key (objeto_id)
    using index (
        create unique index casa_pk on casa(objeto_id)
        tablespace indices_tbs
    ), 
    constraint casa_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)tablespace objetos_tbs
;



-- 
-- table: cuenta_banco 
--
disc
conn u_usr/u_usr

create table cuenta_banco(
    cuenta_banco_id    number(10, 0)    not null,
    clabe              number(18, 0)    not null
        constraint cuenta_banco_clabe_uk unique,
    comprador_id       number(10, 0)    not null,
    banco_id           number(10, 0)    not null,
    constraint cuenta_banco_pk primary key (cuenta_banco_id)
    using index (
        create unique index cuenta_banco_pk on cuenta_banco(cuenta_banco_id)
        tablespace indices_tbs
    ), 
    constraint cuenta_banco_banco_id_fk foreign key (banco_id)
    references banco(banco_id),
    constraint cuenta_banco_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)tablespace compradores_tbs
;



-- 
-- table: tarjeta 
--

create table tarjeta(
    tarjeta_id         number(10, 0)    not null,
    numero             number(16, 0)    not null,
    tipo_tarjeta       varchar2(8)      not null,              
    mes_expiracion     number(2, 0)     not null,
    anio_expiracion    number(2, 0)     not null,
    comprador_id       number(10, 0)    not null,
    constraint tarjeta_pk primary key (tarjeta_id)
    using index (
        create unique index tarjeta_pk on tarjeta(tarjeta_id)
        tablespace indices_tbs
    ), 
    constraint tarjeta_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id),
    constraint tarjeta_tipo_tarjeta_ck check (tipo_tarjeta IN ('debito', 'credito'))
)tablespace compradores_tbs
;



-- 
-- table: factura 
--

create table factura(
    factura_id          number(10, 0)    not null,
    folio               number(10, 0)    not null
        constraint factura_folio_uk unique,
    fecha               date             not null,
    monto_total         number(12, 0)    not null,
    iva                 number(11, 2)    not null,
    tarjeta_id          number(10, 0),
    cuenta_banco_id     number(10, 0),
    constraint factura_pk primary key (factura_id)
    using index (
        create unique index factura_pk on factura(factura_id)
        tablespace indices_tbs
    ), 
    constraint factura_tarjeta_id_fk foreign key (tarjeta_id)
    references tarjeta(tarjeta_id),
    constraint factura_cuenta_banco_id_fk foreign key (cuenta_banco_id)
    references cuenta_banco(cuenta_banco_id)
)tablespace subastas_tbs
;



-- 
-- table: foto_objeto 
--
disc
conn u_obj/u_obj

create table foto_objeto(
    foto_objeto_id    number(10, 0)    not null,
    foto              blob             not null,
    objeto_id         number(10, 0)    not null,
    constraint foto_objeto_pk primary key (foto_objeto_id)
    using index (
        create unique index foto_objeto_pk on foto_objeto(foto_objeto_id)
        tablespace indices_tbs
    ), 
    constraint foto_objeto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)LOB(foto) store as basicfile(tablespace indices_blob_tbs)
tablespace fotos_tbs
;



-- 
-- table: historico_status_objeto 
--

create table historico_status_objeto(
    historico_status_objeto_id    number(10, 0)    not null,
    fecha_status                  date             not null,
    objeto_id                     number(10, 0)    not null,
    status_objeto_id              number(10, 0)    not null,
    constraint historico_status_objeto_pk primary key (historico_status_objeto_id)
    using index (
        create unique index historico_status_objeto_pk on historico_status_objeto(historico_status_objeto_id)
        tablespace indices_tbs
    ), 
    constraint historico_status_objeto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id),
    constraint historico_status_objeto_status_objeto_id_fk foreign key (status_objeto_id)
    references status_objeto(status_objeto_id)
)tablespace historico_tbs
;



-- 
-- table: oferta 
--
disc
conn sys/system2 as sysdba
grant references on u_obj.objeto to u_usr;
disc
conn u_usr/u_usr

create table oferta(
    oferta_id        number(10, 0)    not null,
    fecha            date             not null,
    precio           number(10, 0)    not null,
    comprador_id     number(10, 0)    not null,
    objeto_id        number(10, 0)    not null,
    factura_id       number(10, 0),
    constraint oferta_pk primary key (oferta_id)
    using index (
        create unique index oferta_pk on oferta(oferta_id)
        tablespace indices_tbs
    ), 
    constraint oferta_factura_id_fk foreign key (factura_id)
    references factura(factura_id),
    constraint oferta_objeto_id_fk foreign key (objeto_id)
    references u_obj.objeto(objeto_id),
    constraint oferta_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)tablespace subastas_tbs
;



-- 
-- table: password_comprador 
--

create table password_comprador(
    password_comprador_id    number(10, 0)    not null,
    password                 varchar2(20)     not null,
    comprador_id             number(10, 0),
    constraint password_comprador_pk primary key (password_comprador_id)
    using index (
        create unique index password_comprador_pk on password_comprador(password_comprador_id)
        tablespace indices_tbs
    ), 
    constraint password_comprador_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)tablespace compradores_tbs
;

disc
conn u_obj/u_obj

create unique index auto_num_serie_iuk on auto(num_serie)
tablespace indices_tbs;

create index objeto_propietario_objeto_id_fk on objeto(propietario_objeto_id)
tablespace indices_tbs;

create index objeto_subasta_id_fk on objeto(subasta_id)
tablespace indices_tbs;

create index auto_modelo_id_fk on auto(modelo_id)
tablespace indices_tbs;

create index foto_objeto_objeto_id_fk on foto_objeto(objeto_id)
tablespace indices_tbs;

create index historico_status_objeto_objeto_id_fk on historico_status_objeto(objeto_id)
tablespace indices_tbs;



disc
conn u_usr/u_usr

create unique index comprador_correo_electronico_iuk on comprador(correo_electronico)
tablespace indices_tbs;

create index comprador_pais_id_fk on comprador(pais_id)
tablespace indices_tbs;

create index comprador_aval_id_fk on comprador(aval_id)
tablespace indices_tbs;

create index cuenta_banco_comprador_id_fk on cuenta_banco(comprador_id)
tablespace indices_tbs;

create index tarjeta_comprador_id_fk on tarjeta(comprador_id)
tablespace indices_tbs;

create index oferta_objeto_id_fk on oferta(objeto_id)
tablespace indices_tbs;

create index oferta_comprador_id_fk on oferta(comprador_id)
tablespace indices_tbs;

create index password_comprador_comprador_id_fk on password_comprador(comprador_id)
tablespace indices_tbs;



disc
conn u_obj/u_obj

alter table historico_status_objeto nologging;
alter table foto_objeto nologging;
alter table casa nologging;
alter table auto nologging;
alter table modelo nologging;
alter table marca nologging;
alter table actividad_hacienda nologging;
alter table hacienda nologging;
alter table objeto nologging;
alter table status_objeto nologging;
alter table actividad nologging;



disc
conn u_usr/u_usr

alter table password_comprador nologging;
alter table oferta nologging;
alter table factura nologging;
alter table tarjeta nologging;
alter table cuenta_banco nologging;
alter table banco nologging;
alter table subasta nologging;
alter table comprador nologging;
alter table pais nologging;



-- drop table password_comprador;
-- drop table oferta;
-- drop table historico_status_objeto;
-- drop table foto_objeto;
-- drop table factura;
-- drop table tarjeta;
-- drop table cuenta_banco;
-- drop table casa;
-- drop table banco;
-- drop table auto;
-- drop table modelo;
-- drop table marca;
-- drop table actividad_hacienda;
-- drop table hacienda;
-- drop table objeto;
-- drop table status_objeto;
-- drop table subasta;
-- drop table comprador;
-- drop table pais;
-- drop table actividad;
