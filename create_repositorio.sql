DROP TABLESPACE repositorio_tablas INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE repositorio_indices INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE repositorio_tablas DATAFILE 'df_tablas.DBF' SIZE 500M;
CREATE TABLESPACE repositorio_indices DATAFILE 'df_indices.DBF' SIZE 500M;

DROP USER repositorio CASCADE;
CREATE USER repositorio IDENTIFIED BY 1234;
grant create session, create table, alter session, create trigger to repositorio;

ALTER USER repositorio QUOTA UNLIMITED ON repositorio_tablas;
ALTER USER repositorio QUOTA UNLIMITED ON repositorio_indices;

connect repositorio/1234;

@C:\Users\Abelardo\Desktop\ABDD\proyecto2\create_tables.sql
@C:\Users\Abelardo\Desktop\ABDD\proyecto2\insert_tables.sql

connect system/123456

DROP PUBLIC SYNONYM universidad;

CREATE PUBLIC SYNONYM universidad
FOR repositorio.universidad;

DROP PUBLIC SYNONYM usuario;
CREATE PUBLIC SYNONYM usuario
FOR repositorio.usuario;

DROP PUBLIC SYNONYM evento;
CREATE PUBLIC SYNONYM evento
FOR repositorio.evento;

DROP PUBLIC SYNONYM empresas;
CREATE PUBLIC SYNONYM empresas
FOR repositorio.empresas;

DROP PUBLIC SYNONYM pertenece;
CREATE PUBLIC SYNONYM pertenece
FOR repositorio.pertenece;

DROP PUBLIC SYNONYM patrocinado;
CREATE PUBLIC SYNONYM patrocinado
FOR repositorio.patrocinado;

DROP PUBLIC SYNONYM participa;
CREATE PUBLIC SYNONYM participa
FOR repositorio.participa;

DROP PUBLIC SYNONYM dicta;
CREATE PUBLIC SYNONYM dicta
FOR repositorio.dicta;

DROP USER organizador CASCADE;
CREATE USER organizador IDENTIFIED BY 1234;
grant create session to organizador;
grant select, update, insert, delete on repositorio.usuario to organizador;
grant select, update, insert, delete on repositorio.evento to organizador;
grant select, update, insert, delete on repositorio.participa to organizador;
grant select, update, insert, delete on repositorio.dicta to organizador;


ALTER USER organizador QUOTA UNLIMITED ON repositorio_tablas;
ALTER USER organizador QUOTA UNLIMITED ON repositorio_indices;

DROP USER administrador CASCADE;
CREATE USER administrador IDENTIFIED BY 1234;
grant create session to administrador;
grant select, update, insert, delete on repositorio.universidad to administrador;
grant select, update, insert, delete on repositorio.empresas to administrador;
grant select, update, insert, delete on repositorio.patrocinado to administrador;

ALTER USER administrador QUOTA UNLIMITED ON repositorio_tablas;
ALTER USER administrador QUOTA UNLIMITED ON repositorio_indices;

revoke create session from repositorio;

ALTER DATABASE BEGIN BACKUP;




