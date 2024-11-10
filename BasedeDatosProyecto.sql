/* Creación de la base de datos */
CREATE DATABASE tickets;

/*Selección de la base de datos a usar */
USE tickets;

/* creación de las tablas */
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20),
    correo VARCHAR(30) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    puesto VARCHAR(20) NOT NULL DEFAULT 1,
    activo INT NOT NULL DEFAULT 1
)
ENGINE = MyISAM;

CREATE TABLE bajaUsuarios (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idUsuario INT NOT NULL,
    fecha DATETIME NOT NULL,
    responsableBaja INT NOT NULL,
    /*Definición de claves foraneas*/
    CONSTRAINT FK_bajaUsuariosUsuarioId FOREIGN KEY (idUsuario)
    REFERENCES usuarios(id),
    /* 
        Esta clave foranea funcionara para referenciar al administrador para los
        Responsables de Usuarios
    */
    CONSTRAINT FK_bajaUsuariosResponsablesUsuarioId FOREIGN KEY (responsableBaja)
    REFERENCES usuarios(id)
)
ENGINE = MyISAM;

CREATE TABLE tickets(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    correo VARCHAR(30) NOT NULL,
    asunto VARCHAR(80) NOT NULL,
    equipo VARCHAR(40) NOT NULL,
    mensaje VARCHAR(120) NOT NULL,
    codigoRecibo VARCHAR(10) NOT NULL,
    prioridad VARCHAR(10) NOT NULL,
    fechaRegistro DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    idUsuario INT,
    fechaConclusion DATETIME NOT NULL,
    activo INT NOT NULL DEFAULT 1,
    CONSTRAINT FK_TicketsUsuarios FOREIGN KEY (idUsuario)
    REFERENCES usuarios(id)
)
ENGINE = MyISAM;

CREATE TABLE bajaTickets (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idTicket INT NOT NULL,
    fecha DATETIME NOT NULL,
    responsableBaja INT NOT NULL,
    CONSTRAINT FK_bajaTicketsTickets FOREIGN KEY (idTicket)
    REFERENCES tickets(id),
    CONSTRAINT FK_bajaTicketsUsuarios FOREIGN KEY (responsableBaja)
    REFERENCES usuarios(id)
)
ENGINE = MyISAM;

/* Definición de los usuarios de la base de datos */
CREATE USER 'administrador'@'localhost' IDENTIFIED BY '12345678';
/* administrador tendrá permisos para Altas, Bajas, Cambios y Consultas */
GRANT INSERT, DELETE, UPDATE, SELECT ON tickets.* TO 'administrador'@'localhost';

CREATE USER 'tecnico'@'localhost' IDENTIFIED BY '12345678';
/* tecnico tendrá permisos para Altas, Cambios y Consultas */
GRANT INSERT, UPDATE, SELECT ON tickets.* TO 'tecnico'@'localhost';

CREATE USER 'usuario'@'localhost' IDENTIFIED BY '12345678';
/* usuario tendrá permisos para Altas y Consultas */
GRANT INSERT, SELECT ON tickets.tickets TO 'usuario'@'localhost';