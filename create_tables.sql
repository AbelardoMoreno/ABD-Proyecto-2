CREATE TABLE universidad(
	id_universidad number,
	nombre_universidad varchar (52) NOT NULL,
	descripcion varchar(510),
	fecha_creacion date,
	acronimo varchar2(3),
	CONSTRAINT acronimo_check check (REGEXP_LIKE(acronimo,'[[:alpha:]]{1,4}'))
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX id_universidad_indx ON universidad(id_universidad) TABLESPACE repositorio_indices;
CREATE INDEX nombre_universidad_indx ON universidad(nombre_universidad) TABLESPACE repositorio_indices;
ALTER TABLE universidad ADD CONSTRAINT id_universidad_pk PRIMARY KEY (id_universidad);

CREATE TABLE usuario(
	id_usuario number,
	nombre_usuario varchar (52) NOT NULL,
	apellido_usuario varchar (52) NOT NULL,
	correo varchar2(320) check (REGEXP_LIKE(correo, '[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]')) NOT NULL,
	direccion varchar2(512),
	telefono varchar(52),
	CONSTRAINT correo_unico UNIQUE (correo)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX id_usuario_indx ON usuario(id_usuario) TABLESPACE repositorio_indices;
CREATE INDEX nombre_usuario_indx ON usuario(nombre_usuario) TABLESPACE repositorio_indices;
ALTER TABLE usuario ADD CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario);

CREATE TABLE evento(
	id_evento number,
	nombre_evento varchar (52) NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	check (fecha_fin > fecha_inicio)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX id_evento_indx ON evento(id_evento) TABLESPACE repositorio_indices;
CREATE INDEX nombre_evento_indx ON evento(nombre_evento) TABLESPACE repositorio_indices;
ALTER TABLE evento ADD CONSTRAINT id_evento_pk PRIMARY KEY (id_evento);

CREATE TABLE empresas(
	id_empresas number,
	nombre_empresas varchar (52) NOT NULL,
	direccion varchar2(521),
	telefono varchar(52),
	tipo varchar2(52) check(tipo in ('privada','publica'))
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX id_empresas_indx ON empresas(id_empresas) TABLESPACE repositorio_indices;
CREATE INDEX nombre_empresas_indx ON empresas(nombre_empresas) TABLESPACE repositorio_indices;
ALTER TABLE empresas ADD CONSTRAINT id_empresas_pk PRIMARY KEY (id_empresas);

CREATE TABLE pertenece(
	id_usuario number,
	id_universidad number,
	fecha_ingreso date NOT NULL,
	constraint pertenece_usuario_fk foreign key (id_usuario) references usuario(id_usuario),
	constraint pertenece_universidad_fk foreign key (id_universidad) references universidad(id_universidad)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX pertenece_pk_indx ON pertenece(id_usuario, id_universidad) TABLESPACE repositorio_indices;
ALTER TABLE pertenece ADD CONSTRAINT pertenece_pk PRIMARY KEY (id_usuario, id_universidad);


CREATE TABLE patrocinado(
	id_evento number,
	id_empresas number,
	donacion_dinero number check(donacion_dinero>0) NOT NULL,
	fecha_donacion date NOT NULL,
	constraint patrocinado_evento_fk foreign key (id_evento) references evento(id_evento),
	constraint patrocinado_empresa_fk foreign key (id_empresas) references empresas(id_empresas)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX patrocinado_pk_indx ON patrocinado(id_evento, id_empresas) TABLESPACE repositorio_indices;
ALTER TABLE patrocinado ADD CONSTRAINT patrocinado_pk PRIMARY KEY (id_evento, id_empresas);

CREATE TABLE participa(
	id_usuario number,
	id_evento number,
	constraint participa_usuario_fk foreign key (id_usuario) references usuario(id_usuario),
	constraint participa_evento_fk foreign key (id_evento) references evento(id_evento)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX participa_pk_indx ON participa(id_usuario, id_evento) TABLESPACE repositorio_indices;
ALTER TABLE participa ADD CONSTRAINT participa_pk PRIMARY KEY (id_usuario, id_evento);

CREATE TABLE dicta(
	id_usuario number,
	id_evento number,
	nombre_charla varchar2(52) NOT NULL,
	valoracion_charla number check (valoracion_charla in ('1','2','3','4','5')) NOT NULL,
	valoracion_ponencia number check (valoracion_ponencia in ('1','2','3','4','5')) NOT NULL,
	constraint dicta_usuario_fk foreign key (id_usuario) references usuario(id_usuario),
	constraint dicta_evento_fk foreign key (id_evento) references evento(id_evento)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX dicta_pk_indx ON dicta(id_usuario, id_evento) TABLESPACE repositorio_indices;
ALTER TABLE dicta ADD CONSTRAINT dicta_pk PRIMARY KEY (id_usuario, id_evento);