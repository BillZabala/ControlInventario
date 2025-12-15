CREATE DATABASE IF NOT EXISTS dbcontrolinventariopro;
USE dbcontrolinventariopro;

-- Tabla Usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    idusuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    rol VARCHAR(20) NOT NULL DEFAULT 'USER', -- ADMIN, USER
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO', -- ACTIVO, INACTIVO
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla Categorias
CREATE TABLE IF NOT EXISTS categorias (
    idcategoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO'
);

-- Tabla Productos
CREATE TABLE IF NOT EXISTS productos (
    idproducto INT AUTO_INCREMENT PRIMARY KEY,
    idcategoria INT NOT NULL,
    idproveedor INT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagen VARCHAR(255),
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idcategoria) REFERENCES categorias(idcategoria),
    FOREIGN KEY (idproveedor) REFERENCES proveedores(idproveedor)
);

-- Insertar Admin por defecto (password: admin123)
INSERT INTO usuarios (nombre_usuario, password, nombre_completo, email, rol) 
VALUES ('admin', 'admin123', 'Administrador del Sistema', 'admin@sistema.com', 'ADMIN')
ON DUPLICATE KEY UPDATE nombre_usuario=nombre_usuario;

-- Stored Procedures Usuarios

DELIMITER //

CREATE PROCEDURE sp_autenticarUsuario(IN p_usuario VARCHAR(50), IN p_password VARCHAR(100))
BEGIN
    SELECT * FROM usuarios WHERE nombre_usuario = p_usuario AND password = p_password AND estado = 'ACTIVO';
END //

CREATE PROCEDURE sp_listarUsuarios()
BEGIN
    SELECT * FROM usuarios ORDER BY idusuario DESC;
END //

CREATE PROCEDURE sp_insertarUsuario(
    IN p_usuario VARCHAR(50),
    IN p_password VARCHAR(100),
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_rol VARCHAR(20)
)
BEGIN
    INSERT INTO usuarios (nombre_usuario, password, nombre_completo, email, rol)
    VALUES (p_usuario, p_password, p_nombre, p_email, p_rol);
END //

CREATE PROCEDURE sp_obtenerUsuario(IN p_id INT)
BEGIN
    SELECT * FROM usuarios WHERE idusuario = p_id;
END //

CREATE PROCEDURE sp_modificarUsuario(
    IN p_id INT,
    IN p_usuario VARCHAR(50),
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_rol VARCHAR(20),
    IN p_estado VARCHAR(20)
)
BEGIN
    UPDATE usuarios 
    SET nombre_usuario = p_usuario,
        nombre_completo = p_nombre,
        email = p_email,
        rol = p_rol,
        estado = p_estado
    WHERE idusuario = p_id;
END //

CREATE PROCEDURE sp_cambiarPassword(IN p_id INT, IN p_password VARCHAR(100))
BEGIN
    UPDATE usuarios SET password = p_password WHERE idusuario = p_id;
END //

CREATE PROCEDURE sp_eliminarUsuario(IN p_id INT)
BEGIN
    UPDATE usuarios SET estado = 'INACTIVO' WHERE idusuario = p_id;
END //

-- Stored Procedures Categorias

CREATE PROCEDURE sp_listarCategorias()
BEGIN
    SELECT * FROM categorias WHERE estado = 'ACTIVO' ORDER BY nombre ASC;
END //

CREATE PROCEDURE sp_insertarCategoria(
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    INSERT INTO categorias (nombre, descripcion) VALUES (p_nombre, p_descripcion);
END //

CREATE PROCEDURE sp_obtenerCategoria(IN p_id INT)
BEGIN
    SELECT * FROM categorias WHERE idcategoria = p_id;
END //

CREATE PROCEDURE sp_modificarCategoria(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    UPDATE categorias SET nombre = p_nombre, descripcion = p_descripcion WHERE idcategoria = p_id;
END //

CREATE PROCEDURE sp_eliminarCategoria(IN p_id INT)
BEGIN
    UPDATE categorias SET estado = 'INACTIVO' WHERE idcategoria = p_id;
END //

-- Stored Procedures Productos

CREATE PROCEDURE sp_listarProductos()
BEGIN
    SELECT p.idproducto, p.idcategoria, p.idproveedor, p.nombre, p.descripcion, p.precio, p.stock, p.imagen, p.estado as estado_producto, p.fecha_creacion, c.nombre as nombre_categoria, prv.nombre as nombre_proveedor
    FROM productos p
    INNER JOIN categorias c ON p.idcategoria = c.idcategoria
    LEFT JOIN proveedores prv ON p.idproveedor = prv.idproveedor
    WHERE p.estado = 'ACTIVO'
    ORDER BY p.nombre ASC;
END //

CREATE PROCEDURE sp_insertarProducto(
    IN p_idcategoria INT,
    IN p_idproveedor INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_imagen VARCHAR(255)
)
BEGIN
    INSERT INTO productos (idcategoria, idproveedor, nombre, descripcion, precio, stock, imagen)
    VALUES (p_idcategoria, p_idproveedor, p_nombre, p_descripcion, p_precio, p_stock, p_imagen);
END //

CREATE PROCEDURE sp_obtenerProducto(IN p_id INT)
BEGIN
    SELECT * FROM productos WHERE idproducto = p_id;
END //

CREATE PROCEDURE sp_modificarProducto(
    IN p_id INT,
    IN p_idcategoria INT,
    IN p_idproveedor INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_imagen VARCHAR(255)
)
BEGIN
    UPDATE productos 
    SET idcategoria = p_idcategoria,
        idproveedor = p_idproveedor,
        nombre = p_nombre,
        descripcion = p_descripcion,
        precio = p_precio,
        stock = p_stock,
        imagen = p_imagen
    WHERE idproducto = p_id;
END //

CREATE PROCEDURE sp_eliminarProducto(IN p_id INT)
BEGIN
    UPDATE productos SET estado = 'INACTIVO' WHERE idproducto = p_id;
END //

DELIMITER ;

-- Stored Procedures Dashboard

DELIMITER //

CREATE PROCEDURE sp_contarProductos()
BEGIN
    SELECT COUNT(*) as total FROM productos WHERE estado = 'ACTIVO';
END //

CREATE PROCEDURE sp_contarCategorias()
BEGIN
    SELECT COUNT(*) as total FROM categorias WHERE estado = 'ACTIVO';
END //

CREATE PROCEDURE sp_contarUsuarios()
BEGIN
    SELECT COUNT(*) as total FROM usuarios WHERE estado = 'ACTIVO';
END //

CREATE PROCEDURE sp_contarStockBajo()
BEGIN
    SELECT COUNT(*) as total FROM productos WHERE stock < 10 AND estado = 'ACTIVO';
END //

-- Tabla Movimientos
CREATE TABLE IF NOT EXISTS movimientos (
    idmovimiento INT AUTO_INCREMENT PRIMARY KEY,
    idproducto INT NOT NULL,
    tipo VARCHAR(20) NOT NULL, -- ENTRADA, SALIDA
    cantidad INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idproducto) REFERENCES productos(idproducto)
);

CREATE PROCEDURE sp_listarMovimientos()
BEGIN
    SELECT m.*, p.nombre as nombre_producto 
    FROM movimientos m
    INNER JOIN productos p ON m.idproducto = p.idproducto
    ORDER BY m.fecha DESC LIMIT 10;
END //

CREATE PROCEDURE sp_registrarMovimiento(
    IN p_idproducto INT,
    IN p_tipo VARCHAR(20),
    IN p_cantidad INT
)
BEGIN
    INSERT INTO movimientos (idproducto, tipo, cantidad) VALUES (p_idproducto, p_tipo, p_cantidad);
END //

DELIMITER ;

-- Tabla Proveedores
CREATE TABLE IF NOT EXISTS proveedores (
    idproveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

-- Stored Procedures Proveedores

CREATE PROCEDURE sp_listarProveedores()
BEGIN
    SELECT * FROM proveedores WHERE estado = 'ACTIVO' ORDER BY nombre ASC;
END //

CREATE PROCEDURE sp_insertarProveedor(
    IN p_nombre VARCHAR(100),
    IN p_contacto VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_direccion TEXT
)
BEGIN
    INSERT INTO proveedores (nombre, contacto, telefono, email, direccion) 
    VALUES (p_nombre, p_contacto, p_telefono, p_email, p_direccion);
END //

CREATE PROCEDURE sp_obtenerProveedor(IN p_id INT)
BEGIN
    SELECT * FROM proveedores WHERE idproveedor = p_id;
END //

CREATE PROCEDURE sp_modificarProveedor(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_contacto VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_direccion TEXT
)
BEGIN
    UPDATE proveedores 
    SET nombre = p_nombre, 
        contacto = p_contacto, 
        telefono = p_telefono, 
        email = p_email, 
        direccion = p_direccion 
    WHERE idproveedor = p_id;
END //

CREATE PROCEDURE sp_eliminarProveedor(IN p_id INT)
BEGIN
    UPDATE proveedores SET estado = 'INACTIVO' WHERE idproveedor = p_id;
END //

DELIMITER ;
