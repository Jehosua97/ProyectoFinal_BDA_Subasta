#--@Autores:Chavira Tapia Andrés Uriel
#--			Joya Venegas Jehosua Alan
#--@Fecha	18/06/2020
#--@Descripcion	Instrucciones DDL para crear tablas e índices con base en el modelo relacional elaborado.


-- 
-- table: actividad 
--

create table actividad(
    actividad_id             number(10, 0)    not null,
    descripcion              varchar2(40)     not null,
    constraint actividad_pk primary key (actividad_id)
    using index (
        create unique index actividad_pk on actividad(actividad_id)
        tablespace indices_tbs
)tablespace objetos_tbs
;



-- 
-- table: pais 
--

create table pais(
    pais_id        number(10, 0)    not null,
    clave          char(2)          not null
        constraint pais_clave_uk unique,
    nombre         varchar2(40)     not null,
    constraint pais_pk primary key (pais_id)
    using index (
        create unique index pais_pk on pais(pais_id)
        tablespace indices_tbs
    ),
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
        contraint comprador_usuario_uk unique,
    rfc                   varchar2(13)     not null
        constraint comprador_rfc_uk unique,
    direccion             varchar2(40)     not null,
    pais_id               number(10, 0)    not null,
    aval_id               number(10, 0)    not null,
    constraint comprador_pk primary key (comprador_id)
    using index (
        create unique index comprador_pk on comprador(comprador_id)
        tablespace indices_tbs
    ), 
    constraint pais_pais_id_fk foreign key (pais_id)
    references pais(pais_id),
    constraint pais_aval_id_fk foreign key (aval_id)
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

create table status_objeto(
    status_objeto_id    number(10, 0)    not null
                        constraint clave_ck check (status_objeto_id disp, comp, entr, desc),
    clave               char(4)          not null,
    descripcion         varchar2(40)     not null,
    constraint status_objeto_pk primary key (status_objeto_id)
    using index (
        create unique index status_objeto_pk on status_objeto(status_objeto_id)
        tablespace indices_tbs
    )
)tablespace archivo_tbs
;



-- 
-- table: objeto 
--

create table objeto(
    objeto_id                number(10, 0)    not null,
    nombre                   varchar2(40)     not null,
    descripcion              varchar2(40)     not null,
    precio_inicial           number(12, 0)    not null,
    codigo_barras            number(14, 0)    not null,
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
    references comprador(comprador_id),
    constraint objeto_subasta_id_fk foreign key (subasta_id)
    references subasta(subasta_id),
    constraint objeto_status_objeto_id_fk foreign key (status_objeto_id)
    references status_objeto(status_objeto_id)
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
        tablespace indices_tbs, 
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
        tablespace indices_tbs, 
    constraint auto_modelo_id_fk foreign key (modelo_id)
    references modelo(modelo_id),
    constraint auto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)tablespace objetos_tbs
;



-- 
-- table: banco 
--

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
)tablespace compradores_tbs
;



-- 
-- table: casa 
--

create table casa(
    objeto_id          number(10, 0)    not null,
    latitud            number(2, 2)     not null,
    longitud           number(2, 2)     not null,
    direccion          varchar2(40)     not null,
    caracteristicas    varchar2(40)     not null,
    constraint casa_pk primary key (objeto_id)
    using index (
        create unique index casa_pk on casa(objeto_id)
        tablespace indices_tbs, 
    constraint casa_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)tablespace objetos_tbs
;



-- 
-- table: cuenta_banco 
--

create table cuenta_banco(
    cuenta_banco_id    number(10, 0)    not null,
    clabe              number(18, 0)    not null
        constraint cuenta_banco_clabe_uk unique,
    comprador_id       number(10, 0)    not null,
    banco_id           number(10, 0)    not null,
    constraint cuenta_banco_pk primary key (cuenta_banco_id)
    using index (
        create unique index cuenta_banco_pk on cuenta_banco(cuenta_banco_id)
        tablespace indices_tbs, 
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
    tipo_tarjeta       varchar2(8)      not null
                       
    mes_expiracion     number(2, 0)     not null,
    anio_expiracion    number(2, 0)     not null,
    comprador_id       number(10, 0)    not null,
    constraint tarjeta_pk primary key (tarjeta_id)
    using index (
        create unique index tarjeta_pk on tarjeta(tarjeta_id)
        tablespace indices_tbs, 
    constraint tarjeta_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
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
        tablespace indices_tbs, 
    constraint factura_tarjeta_id_fk foreign key (tarjeta_id)
    references tarjeta(tarjeta_id),
    constraint factura_cuenta_banco_id_fk foreign key (cuenta_banco_id)
    references cuenta_banco(cuenta_banco_id)
)tablespace subastas_tbs
;



-- 
-- table: foto_objeto 
--

create table foto_objeto(
    foto_objeto_id    number(10, 0)    not null,
    foto              blob             not null,
    objeto_id         number(10, 0)    not null,
    constraint foto_objeto_pk primary key (foto_objeto_id)
    using index (
        create unique index foto_objeto_pk on foto_objeto(foto_objeto_id)
        tablespace indices_tbs, 
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
        tablespace indices_tbs, 
    constraint historico_status_objeto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id),
    constraint historico_status_objeto_status_objeto_id_fk foreign key (status_objeto_id)
    references status_objeto(status_objeto_id)
)tablespace archivo_tbs
;



-- 
-- table: oferta 
--

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
        tablespace indices_tbs, 
    constraint oferta_factura_id_fk foreign key (factura_id)
    references factura(factura_id),
    constraint oferta_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id),
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
        tablespace indices_tbs, 
    constraint password_comprador_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)tablespace compradores_tbs
;

--Índices UNIQUE
create unique index comprador_correo_electronico_iuk on comprador(correo_electronico)
tablespace indices_tbs;

create unique index auto_num_serie_iuk on auto(num_serie)
tablespace indices_tbs;

--Índices FK (NONUNIQUE)
create index comprador_pais_id_fk on comprador(pais_id)
tablespace indices_tbs;

create index comprador_aval_id_fk on comprador(aval_id)
tablespace indices_tbs;

create index objeto_propietario_objeto_id_fk on objeto(propietario_objeto_id)
tablespace indices_tbs;

create index objeto_subasta_id_fk on objeto(subasta_id)
tablespace indices_tbs;

-- status_objeto probablemente contenga menos de 50 registros.
-- create index objeto_status_objeto_id_fk on objeto(status_objeto_id)
-- tablespace indices_tbs;

-- hacienda probablemente no consulte objeto_id más que en su creación.
-- create index hacienda_objeto_id_fk on hacienda(objeto_id)
-- tablespace indices_tbs;

-- actividad probablemente contenga menos de 50 registros.
-- create index actividad_hacienda_actividad_id_fk on actividad_hacienda(actividad_id)
-- tablespace indices_tbs;


-- marca probablemente contenga menos de 50 registros.
-- create index modelo_marca_id_fk on modelo(marca_id)
-- tablespace indices_tbs;

create index auto_modelo_id_fk on auto(modelo_id)
tablespace indices_tbs;

-- auto probablemente no consulte objeto_id más que en su creación.
-- create index auto_objeto_id_fk on auto(objeto_id)
-- tablespace indices_tbs;

-- casa probablemente no consulte objeto_id más que en su creación.
-- create index casa_objeto_id_fk on casa(objeto_id)
-- tablespace indices_tbs;

-- banco probablemente contenga menos de 50 registros.
-- create index cuenta_banco_banco_id_fk on cuenta_banco(banco_id)
-- tablespace indices_tbs;

create index cuenta_banco_comprador_id_fk on cuenta_banco(comprador_id)
tablespace indices_tbs;

create index tarjeta_comprador_id_fk on tarjeta(comprador_id)
tablespace indices_tbs;

-- factura probablemente consulte tarjeta_id únicamente durante su creación.
-- create index factura_tarjeta_id_fk on factura(tarjeta_id)
-- tablespace indices_tbs;

-- factura probablemente consulte tarjeta_id únicamente durante su creación.
-- create index factura_cuenta_banco_id_fk on factura(cuenta_banco_id)
-- tablespace indices_tbs;

create index foto_objeto_objeto_id_fk on foto_objeto(objeto_id)
tablespace indices_tbs;

create index historico_status_objeto_objeto_id_fk on historico_status_objeto(objeto_id)
tablespace indices_tbs;

-- status_objeto probablemente contenga menos de 50 registros.
-- create index historico_status_objeto_status_objeto_id_fk on historico_status_objeto(status_objeto_id)
-- tablespace indices_tbs;

-- oferta probablemente consulte factura_id únicamente después de su creación, al actualizar el campo.
-- create index oferta_factura_id_fk on oferta(factura_id)
-- tablespace indices_tbs;

create index oferta_objeto_id_fk on oferta(objeto_id)
tablespace indices_tbs;

create index oferta_comprador_id_fk on oferta(comprador_id)
tablespace indices_tbs;

create index password_comprador_comprador_id_fk on password_comprador(comprador_id)
tablespace indices_tbs;
