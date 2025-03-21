## CQRS con SQL y SQL - Proyecto con Docker

## Introducción a CQRS 

Command Query Responsibility Segregation (CQRS) es un patrón arquitectónico que separa las operaciones de lectura de las operaciones de escritura en un sistema. Esto permite optimizar cada operación de manera independiente, mejorando la escalabilidad y el rendimiento.

##  Ejemplo de CQRS

En este proyecto, implementamos CQRS utilizando dos bases de datos PostgreSQL separadas:

write_db: Base de datos para operaciones de escritura (INSERT, UPDATE, DELETE).

read_db: Base de datos para operaciones de lectura (SELECT). Esta base de datos se puede poblar con datos de la base de datos de escritura mediante replicación o sincronización manual.

# Requisitos previos

## Tener instalado:

#### Docker

#### Docker Compose

#### PostreSQL

Para verificar la instalación, ejecuta:
#### bash
- docker compose version

Pasos para ejecutar el proyecto

1. Clonar el repositorio - git clone https://github.com/diego-centella-jalafund/CQRS-db.git

2. Construir y ejecutar los contenedores

3. Verificar que los contenedores estén corriendo
- Deberías ver dos contenedores: write_db y read_db.

4. Para la ejecucion del script write ejecutar: docker exec -it write_db psql -U user -d write_db -f /docker-entrypoint-initdb.d/writeScript.sql

5. Para la ejecucion del script read ejecutar: docker exec -it read_db psql -U user -d read_db -f /docker-entrypoint-initdb.d/readScript.sql
 

6. Conectarse a la base de datos de escritura:
#### bash
- psql -h localhost -p 5440 -U user -d write_db
- password
#### sql
- Visualizar que la tabla orders se ha creado correctamente: select * from orders;

7. Conectarse a la base de datos de lectura y sincronizar con la bases de datos de escritura
#### bash 
- Intentar sincronizar los datos: docker exec -it write_db pg_dump -U user --data-only write_db | docker exec -i read_db psql -U user -d read_db

- Conectarse a la db de lectura: psql -h localhost -p 5441 -U user -d read_db
- password
#### sql
8. Verificar que se haya creado la tabla con sus elementos correspondientes:
#### sql
- select * from orders;

9. Separacion de comandos y queries
#### sql
- SELECT * FROM get_orders();

10. Ejecuta las funciones de create, update y delete en la bases de datos de escritura
#### sql
- SELECT create_order('Cliente 2', 200.00);
- SELECT update_order(1, 'Nuevo Cliente', 150.00);
- SELECT delete_order(1);

#### bash

11. reinicia la tabla de orders: 
#### sql
- TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
#### bash
11. Sincroniza las bases de datos: docker exec -it write_db pg_dump -U user --data-only write_db | docker exec -i read_db psql -U user -d read_db

12. Ejecuta los comandos para leer en la base de datos de read
#### sql
- SELECT * FROM get_orders();

Sincronización entre bases de datos, para mantener read_db actualizada

Conclusión

Este proyecto demuestra el patrón CQRS usando dos bases de datos PostgreSQL separadas para operaciones de lectura y escritura. Esto mejora la escalabilidad y optimiza el rendimiento del sistema.