CREATE TABLE paises (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE ciudades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais_id INT REFERENCES paises(id) NOT NULL
);

CREATE TABLE marca (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    pais_id INT REFERENCES paises(id) NOT NULL
);

CREATE TABLE tipos_combustible (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE carros (
    placa VARCHAR(6) PRIMARY KEY CHECK (placa ~ '^[A-Z]{3}[0-9]{3}$'),
    marca_id INT REFERENCES marca(id) NOT NULL,
    linea VARCHAR(30) NOT NULL,
    ano INT NOT NULL,
    color VARCHAR(20) NOT NULL,
    cilindraje INT NOT NULL,
    motor_serie VARCHAR(30) NOT NULL,
    chasis_vin VARCHAR(17) NOT NULL UNIQUE,
    combustible_id INT REFERENCES tipos_combustible(id) NOT NULL
);

CREATE TABLE vendedores (
    cedula VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    direccion VARCHAR(150) NOT NULL,
    ciudad_id INT REFERENCES ciudades(id) NOT NULL
);

CREATE TABLE clientes (
    cedula VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    ciudad_id INT REFERENCES ciudades(id) NOT NULL
);

CREATE TABLE soat (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    fecha_emision DATE NOT NULL,
    vigencia_hasta DATE NOT NULL,
    aseguradora VARCHAR(50) NOT NULL
);

CREATE TABLE tecnomecanica (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    vigencia_hasta DATE NOT NULL,
    centro_diagnostico VARCHAR(100) NOT NULL
);

CREATE TABLE licencia_transito (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    numero_licencia VARCHAR(20) NOT NULL UNIQUE,
    organismo_transito VARCHAR(50) NOT NULL
);

CREATE TABLE factura (
    numero_factura VARCHAR(15) PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    cliente_cedula VARCHAR(10) REFERENCES clientes(cedula) NOT NULL,
    vendedor_cedula VARCHAR(10) REFERENCES vendedores(cedula) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_neto DECIMAL(12,2) NOT NULL,
    iva_porcentaje DECIMAL(4,2) NOT NULL,
    total_pagado DECIMAL(12,2) NOT NULL
);

CREATE TABLE multas (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    fecha_infraccion TIMESTAMP NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    descripcion TEXT,
    pagada BOOLEAN DEFAULT FALSE
);

CREATE TABLE inventario_estado (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    disponible BOOLEAN NOT NULL,
    fecha_ingreso DATE NOT NULL,
    precio_compra DECIMAL(12,2) NOT NULL,
    costo_preparacion_venta DECIMAL(12,2) DEFAULT 0
);

CREATE TABLE historial_propietarios (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    cedula_propietario VARCHAR(10) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    CONSTRAINT check_fechas CHECK (fecha_fin IS NULL OR fecha_fin > fecha_inicio)
);

CREATE TABLE peritajes_mecanicos (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(6) REFERENCES carros(placa) NOT NULL,
    fecha_peritaje TIMESTAMP NOT NULL,
    resultado_descripcion TEXT,
    costo_revision DECIMAL(12,2) NOT NULL
);