--
-- er/studio data architect sql code generation
-- project :      modelado er.dm1
--
-- date created : thursday, june 18, 2020 15:00:38
-- target dbms : oracle 12c
--

-- 
-- table: actividad 
--

create table actividad(
    actividad_id             number(10, 0)    not null,
    descripcion_actividad    varchar2(40)     not null,
    constraint actividad_pk primary key (actividad_id)
)
;



-- 
-- table: pais 
--

create table pais(
    pais_id        number(10, 0)    not null,
    clave_pais     char(2)          not null,
    nombre_pais    varchar2(40)     not null,
    constraint pais_pk primary key (pais_id)
)
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
    foto_perfil           long raw         not null,
    resenia               varchar2(40)     not null,
    usuario               varchar2(20)     not null,
    rfc                   varchar2(13)     not null,
    direccion             varchar2(40)     not null,
    pais_id               number(10, 0)    not null,
    aval_id               number(10, 0)    not null,
    constraint comprador_pk primary key (comprador_id), 
    constraint pais_id_fk foreign key (pais_id)
    references pais(pais_id),
    constraint aval_id_fk foreign key (aval_id)
    references comprador(comprador_id)
)
;



-- 
-- table: subasta 
--

create table subasta(
    subasta_id              number(10, 0)    not null,
    fecha_subasta           date             not null,
    direccion_internet      varchar2(40)     not null,
    recaduacion_estimada    number(10, 0)    not null,
    recaudacion             number(10, 0),
    constraint subasta_pk primary key (subasta_id)
)
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
)
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
    constraint objeto_pk primary key (objeto_id), 
    constraint propietario_objeto_id_fk foreign key (propietario_objeto_id)
    references comprador(comprador_id),
    constraint subasta_id_fk foreign key (subasta_id)
    references subasta(subasta_id),
    constraint status_objeto_id_fk foreign key (status_objeto_id)
    references status_objeto(status_objeto_id)
)
;



-- 
-- table: hacienda 
--

create table hacienda(
    objeto_id             number(10, 0)    not null,
    nombre_hacienda       varchar2(40)     not null,
    extension_km_2        number(10, 2)    not null,
    direccion_hacienda    varchar2(40)     not null,
    constraint hacienda_pk primary key (objeto_id), 
    constraint hacienda_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)
;



-- 
-- table: actividad_hacienda 
--

create table actividad_hacienda(
    objeto_id       number(10, 0)    not null,
    actividad_id    number(10, 0)    not null,
    constraint actividad_hacienda_pk primary key (objeto_id, actividad_id), 
    constraint actividad_id_fk foreign key (actividad_id)
    references actividad(actividad_id),
    constraint actividad_hacienda_objeto_id_fk foreign key (objeto_id)
    references hacienda(objeto_id)
)
;



-- 
-- table: marca 
--

create table marca(
    marca_id        number(10, 0)    not null,
    nombre_marca    varchar2(40)     not null,
    constraint marca_pk primary key (marca_id)
)
;



-- 
-- table: modelo 
--

create table modelo(
    modelo_id        number(10, 0)    not null,
    nombre_modelo    varchar2(40)     not null,
    marca_id         number(10, 0)    not null,
    constraint modelo_pk primary key (modelo_id), 
    constraint marca_id_fk foreign key (marca_id)
    references marca(marca_id)
)
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
    constraint auto_pk primary key (objeto_id), 
    constraint modelo_id_fk foreign key (modelo_id)
    references modelo(modelo_id),
    constraint auto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)
;



-- 
-- table: banco 
--

create table banco(
    banco_id             number(10, 0)    not null,
    clave_banco          char(4)          not null,
    descripcion_banco    varchar2(40)     not null,
    nombre_banco         varchar2(40)     not null,
    constraint banco_pk primary key (banco_id)
)
;



-- 
-- table: casa 
--

create table casa(
    objeto_id          number(10, 0)    not null,
    latitud            number(2, 2)     not null,
    longitud           number(2, 2)     not null,
    direccion_casa     varchar2(40)     not null,
    caracteristicas    varchar2(40)     not null,
    constraint casa_pk primary key (objeto_id), 
    constraint casa_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)
;



-- 
-- table: cuenta_banco 
--

create table cuenta_banco(
    cuenta_banco_id    number(10, 0)    not null,
    clabe              number(18, 0)    not null,
    comprador_id       number(10, 0)    not null,
    banco_id           number(10, 0)    not null,
    constraint cuenta_banco_pk primary key (cuenta_banco_id), 
    constraint cuenta_banco_banco_id_fk foreign key (banco_id)
    references banco(banco_id),
    constraint cuenta_banco_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)
;



-- 
-- table: tarjeta 
--

create table tarjeta(
    tarjeta_id         number(10, 0)    not null,
    numero_tarjeta     number(16, 0)    not null,
    tipo_tarjeta       varchar2(8)      not null
                       constraint cktarjeta check (tipo_tarjeta debito, credito),
    mes_expiracion     number(2, 0)     not null,
    anio_expiracion    number(2, 0)     not null,
    comprador_id       number(10, 0)    not null,
    constraint tarjeta_pk primary key (tarjeta_id), 
    constraint tarjeta_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)
;



-- 
-- table: factura 
--

create table factura(
    factura_id          number(10, 0)    not null,
    folio_factura       number(10, 0)    not null,
    fecha_generacion    date             not null,
    "monto total"       number(12, 0)    not null,
    iva                 number(11, 2)    not null,
    tarjeta_id          number(10, 0),
    cuenta_banco_id     number(10, 0),
    constraint factura_pk primary key (factura_id), 
    constraint tarjeta_id_fk foreign key (tarjeta_id)
    references tarjeta(tarjeta_id),
    constraint factura_cuenta_banco_id_fk foreign key (cuenta_banco_id)
    references cuenta_banco(cuenta_banco_id)
)
;



-- 
-- table: foto_objeto 
--

create table foto_objeto(
    foto_objeto_id    number(10, 0)    not null,
    foto              long raw         not null,
    objeto_id         number(10, 0)    not null,
    constraint foto_objeto_pk primary key (foto_objeto_id), 
    constraint foto_objeto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id)
)
;



-- 
-- table: historico_status_objeto 
--

create table historico_status_objeto(
    historico_status_objeto_id    number(10, 0)    not null,
    fecha_status                  date             not null,
    objeto_id                     number(10, 0)    not null,
    status_objeto_id              number(10, 0)    not null,
    constraint historico_status_objeto_pk primary key (historico_status_objeto_id), 
    constraint historico_status_objeto_objeto_id_fk foreign key (objeto_id)
    references objeto(objeto_id),
    constraint historico_status_objeto_status_objeto_id_fk foreign key (status_objeto_id)
    references status_objeto(status_objeto_id)
)
;



-- 
-- table: oferta 
--

create table oferta(
    oferta_id        number(10, 0)    not null,
    fecha_oferta     date             not null,
    precio_oferta    number(10, 0)    not null,
    comprador_id     number(10, 0)    not null,
    objeto_id        number(10, 0)    not null,
    factura_id       number(10, 0)    not null,
    constraint oferta_pk primary key (oferta_id), 
    constraint reffactura561 foreign key (factura_id)
    references factura(factura_id),
    constraint refobjeto7 foreign key (objeto_id)
    references objeto(objeto_id),
    constraint oferta_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)
;



-- 
-- table: password_comprador 
--

create table password_comprador(
    password_comprador_id    number(10, 0)    not null,
    password                 varchar2(20)     not null,
    comprador_id             number(10, 0),
    constraint password_comprador_pk primary key (password_comprador_id), 
    constraint password_comprador_comprador_id_fk foreign key (comprador_id)
    references comprador(comprador_id)
)
;



