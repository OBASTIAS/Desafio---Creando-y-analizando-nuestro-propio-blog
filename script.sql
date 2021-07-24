\echo 'eliminar DDBB peliculas'
DROP DATABASE blog;

\echo '1. Crear base de datos llamada blog.'
CREATE DATABASE blog;

\echo 'Conectarse DDBB blog'

\c blog;

\echo '2. Crear las tablas indicadas de acuerdo al modelo de datos.'

\echo 'Crear Tabla usuario'
CREATE TABLE usuario(
    id SERIAL PRIMARY KEY,
    email VARCHAR(255)
);

\echo 'Crear Tabla post'
CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    titulo VARCHAR(255),
    fecha DATE
);

\echo 'Crear Tabla comentario'
CREATE TABLE comentario (
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL,
    usuario_id INT NOT NULL,
    texto VARCHAR(255),
    fecha DATE
);

\echo 'Agregar Foreign Key'

ALTER TABLE post
ADD FOREIGN KEY (usuario_id) REFERENCES usuario(id);

ALTER TABLE comentario
ADD FOREIGN KEY (usuario_id) REFERENCES usuario(id);

ALTER TABLE comentario
ADD FOREIGN KEY (post_id) REFERENCES post(id);

\echo '3. Insertar los siguientes registros.'

INSERT INTO usuario(email) VALUES ('usuario01@hotmail.com');
INSERT INTO usuario(email) VALUES ('usuario02@gmail.com');
INSERT INTO usuario(email) VALUES ('usuario03@gmail.com');
INSERT INTO usuario(email) VALUES ('usuario04@hotmail.com');
INSERT INTO usuario(email) VALUES ('usuario05@yahoo.com');
INSERT INTO usuario(email) VALUES ('usuario06@hotmail.com');
INSERT INTO usuario(email) VALUES ('usuario07@yahoo.com');
INSERT INTO usuario(email) VALUES ('usuario08@yahoo.com');
INSERT INTO usuario(email) VALUES ('usuario09@yahoo.com');

INSERT INTO post(usuario_id,titulo,fecha) VALUES (1,'Post 1: Esto es malo','2020-06-29');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (5,'Post 2: Esto es malo','2020-06-20');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (1,'Post 3: Esto es excelente','2020-05-30');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (9,'Post 4: Esto es bueno','2020-05-09');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (7,'Post 5: Esto es bueno','2020-07-10');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (5,'Post 6: Esto es excelente','2020-07-18');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (8,'Post 7: Esto es excelente','2020-07-07');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (5,'Post 8: Esto es excelente','2020-05-14');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (2,'Post 9: Esto es bueno','2020-05-08');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (6,'Post 10: Esto es bueno','2020-06-02');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (4,'Post 11: Esto es bueno','2020-05-05');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (9,'Post 12: Esto es malo','2020-07-23');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (5,'Post 13: Esto es excelente','2020-05-30');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (8,'Post 14: Esto es excelente','2020-05-01');
INSERT INTO post(usuario_id,titulo,fecha) VALUES (7,'Post 15: Esto es malo','2020-06-17');

INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (3 ,6 , 'Este es el comentario 1', '2020-07-08');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (4 ,2 , 'Este es el comentario 2', '2020-06-07');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (6 ,4 , 'Este es el comentario 3', '2020-06-16');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (2 ,13 , 'Este es el comentario 4', '2020-06-15');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (6 ,6 , 'Este es el comentario 5', '2020-05-14');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (3 ,3 , 'Este es el comentario 6', '2020-07-08');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (6 ,1 , 'Este es el comentario 7', '2020-05-22');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (6 ,7 , 'Este es el comentario 8', '2020-07-09');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (8 ,13 , 'Este es el comentario 9', '2020-06-30');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (8 ,6 , 'Este es el comentario 10','2020-06-19');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (5 ,1 , 'Este es el comentario 11', '2020-05-09');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (8 ,15 , 'Este es el comentario 12', '2020-06-17');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (1 ,9 , 'Este es el comentario 13', '2020-05-01');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (2 ,5 , 'Este es el comentario 14', '2020-05-31');
INSERT INTO comentario(usuario_id,post_id,texto,fecha) VALUES (4 ,3 , 'Este es el comentario 15', '2020-06-28');


\echo '4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.'

SELECT u.email,p.id,p.titulo FROM usuario AS u LEFT JOIN post AS p ON u.id = p.usuario_id WHERE u.id = 5;

\echo '5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.'

SELECT u.email, co.id, co.texto FROM usuario AS u  INNER JOIN comentario AS co ON u.id = co.usuario_id WHERE u.email != 'usuario06@hotmail.com';

\echo '6. Listar los usuarios que no han publicado ningún post.'

SELECT u.id , u.email FROM usuario AS u LEFT JOIN post AS p ON p.usuario_id = u.id WHERE p.id is null;

\echo '7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).'

SELECT p.titulo,co.texto FROM post AS p FULL OUTER JOIN comentario AS co ON p.id = co.post_id;

\echo '8. Listar todos los usuarios que hayan publicado un post en Junio.'

SELECT u.email,p.fecha FROM usuario AS u INNER JOIN post AS p ON u.id = p.usuario_id WHERE EXTRACT(MONTH FROM p.fecha) = 6 ;