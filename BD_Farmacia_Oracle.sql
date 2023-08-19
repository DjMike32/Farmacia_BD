-- Creación de la tabla Pais
CREATE TABLE Pais (
    ID_Pais NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

-- Inserción de valores en la tabla Pais
INSERT INTO Pais (Descripcion) VALUES ('Honduras');
INSERT INTO Pais (Descripcion) VALUES ('El Salvador');
INSERT INTO Pais (Descripcion) VALUES ('Nicaragua');
INSERT INTO Pais (Descripcion) VALUES ('Panama');
INSERT INTO Pais (Descripcion) VALUES ('Guatemala');


---------------------- Creación de la tabla Departamento -----------------------
CREATE TABLE Departamento (
    ID_Departamento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Pais NUMBER,
    Descripcion VARCHAR2(45) NOT NULL,
    CONSTRAINT FK_ID_Pais FOREIGN KEY (ID_Pais) REFERENCES Pais (ID_Pais)
);

---------------- Inserción de valores en la tabla Departamento -----------------
INSERT INTO Departamento (ID_Pais, Descripcion) VALUES (1, 'Francisco Morazan');
INSERT INTO Departamento (ID_Pais, Descripcion) VALUES (1, 'Olancho');
INSERT INTO Departamento (ID_Pais, Descripcion) VALUES (1, 'Atlantida');
INSERT INTO Departamento (ID_Pais, Descripcion) VALUES (1, 'Choluteca');
INSERT INTO Departamento (ID_Pais, Descripcion) VALUES (1, 'Comayagua');



----------------------------------- Creación de la tabla Municipio -----------------------------------------
CREATE TABLE Municipio (
    ID_Municipio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL,
    Ciudad VARCHAR(1) NOT NULL,
    ID_Departamento NUMBER,
    CONSTRAINT FK_ID_Departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento (ID_Departamento)
);

------------------------- Inserción de valores en la tabla Municipio ----------------------------
INSERT INTO Municipio (Descripcion, Ciudad, ID_Departamento) VALUES ('Tegucigalpa', 'S', 1);
INSERT INTO Municipio (Descripcion, Ciudad, ID_Departamento) VALUES ('Juticalpa', 'S', 2);
INSERT INTO Municipio (Descripcion, Ciudad, ID_Departamento) VALUES ('La Ceiba', 'S', 3);
INSERT INTO Municipio (Descripcion, Ciudad, ID_Departamento) VALUES ('Choluteca', 'N', 4);
INSERT INTO Municipio (Descripcion, Ciudad, ID_Departamento) VALUES ('Comayagua', 'S', 5);


------------------------------- Creación de la tabla Colonia --------------------------------------
CREATE TABLE Colonia (
    ID_Colonia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45),
    ID_Municipio NUMBER,
    CONSTRAINT FK_ID_Municipio FOREIGN KEY (ID_Municipio) REFERENCES Municipio (ID_Municipio)
);

-- Inserción de valores en la tabla Colonia
INSERT INTO Colonia (Descripcion, ID_Municipio) VALUES ('La Kennedy', 1);
INSERT INTO Colonia (Descripcion, ID_Municipio) VALUES ('Los Angeles', 2);
INSERT INTO Colonia (Descripcion, ID_Municipio) VALUES ('1 de Mayo', 3);
INSERT INTO Colonia (Descripcion, ID_Municipio) VALUES ('San Luis Anach', 4);
INSERT INTO Colonia (Descripcion, ID_Municipio) VALUES ('Los Almendros', 5);

---------------------- Creación de la tabla Direccion --------------------------
CREATE TABLE Direccion (
    ID_Direccion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45),
    GPS VARCHAR2(45),
    ID_Colonia NUMBER,
    CONSTRAINT FK_ID_Colonia FOREIGN KEY (ID_Colonia) REFERENCES Colonia (ID_Colonia)
);

--------------------------------------- Inserción de valores en la tabla Direccion ---------------------------------------------
INSERT INTO Direccion (Descripcion, GPS, ID_Colonia) VALUES ('Cerca del punto de taxis', '12.3456, -78.9012', 1);
INSERT INTO Direccion (Descripcion, GPS, ID_Colonia) VALUES ('A la par de la pulpería los gemelos', '34.5678, -123.4567', 2);
INSERT INTO Direccion (Descripcion, GPS, ID_Colonia) VALUES ('Frente a la iglesia San Juan', '56.7890, -45.6789', 3);
INSERT INTO Direccion (Descripcion, GPS, ID_Colonia) VALUES ('Detrás del parque central', '78.9012, -67.8901', 4);
INSERT INTO Direccion (Descripcion, GPS, ID_Colonia) VALUES ('Junto al mercado municipal', '90.1234, -12.3456', 5);


------------------------------- Creación de la tabla Profesiones -----------------------------------
CREATE TABLE Profesiones (
    ID_Profesion NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

------------------------- Inserción de valores en la tabla Profesiones ---------------------------
INSERT INTO Profesiones (ID_Profesion, Descripcion) VALUES (1, 'Ingeniero');
INSERT INTO Profesiones (ID_Profesion, Descripcion) VALUES (2, 'Médico');
INSERT INTO Profesiones (ID_Profesion, Descripcion) VALUES (3, 'Abogado');
INSERT INTO Profesiones (ID_Profesion, Descripcion) VALUES (4, 'Profesor');
INSERT INTO Profesiones (ID_Profesion, Descripcion) VALUES (5, 'Arquitecto');


------------------------------- Creación de la tabla Persona -----------------------------------
CREATE TABLE Persona (
    ID_Persona NUMBER PRIMARY KEY,
    P_Nombre VARCHAR2(45),
    S_Nombre VARCHAR2(45),
    P_Apellido VARCHAR2(45),
    S_Apellido VARCHAR2(45),
    Genero VARCHAR(1),
    Fecha_Nacimiento DATE,
    Correo VARCHAR2(45),
    Celular NUMBER,
    ID_Direccion NUMBER,
    CONSTRAINT FK_ID_Direccion FOREIGN KEY (ID_Direccion) REFERENCES Direccion (ID_Direccion)
);

----------------------------- Creación de índices -----------------------------------
CREATE INDEX IX_Persona_Correo ON Persona (Correo);
CREATE INDEX IX_Persona_Fecha_Nacimiento ON Persona (Fecha_Nacimiento);

------------------------------------------ Inserción de valores en la tabla Persona -------------------------------------------------------
INSERT INTO Persona (ID_Persona, P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES (1, 'Juan', 'Carlos', 'Pérez', 'García', 'M', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'juan@example.com', 99887766, 1);

INSERT INTO Persona (ID_Persona, P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES (2, 'María', 'Elena', 'López', 'Rodríguez', 'F', TO_DATE('1985-11-20', 'YYYY-MM-DD'), 'maria@example.com', 98765432, 2);

INSERT INTO Persona (ID_Persona, P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES (3, 'Carlos', 'Andrés', 'Martínez', 'Pérez', 'M', TO_DATE('1995-03-10', 'YYYY-MM-DD'), 'carlos@example.com', 87654321, 3);

INSERT INTO Persona (ID_Persona, P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES (4, 'Ana', 'Isabel', 'Ramírez', 'Hernández', 'F', TO_DATE('1982-07-08', 'YYYY-MM-DD'), 'ana@example.com', 76543210, 4);

INSERT INTO Persona (ID_Persona, P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES (5, 'Luis', 'Alberto', 'González', 'Gómez', 'M', TO_DATE('1998-09-25', 'YYYY-MM-DD'), 'luis@example.com', 65432109, 5);


---------------------------- Creación de la tabla Profesiones_Persona --------------------------------
CREATE TABLE Profesiones_Persona (
    Profesion NUMBER PRIMARY KEY,
    ID_Profesion NUMBER,
    ID_Persona NUMBER,
    CONSTRAINT FK_ID_Profesion FOREIGN KEY (ID_Profesion) REFERENCES Profesiones (ID_Profesion),
    CONSTRAINT FK_ID_Persona FOREIGN KEY (ID_Persona) REFERENCES Persona (ID_Persona)
);

---------------------- Inserción de valores en la tabla Profesiones_Persona -------------------------
INSERT INTO Profesiones_Persona (Profesion, ID_Profesion, ID_Persona) VALUES (1, 1, 1);
INSERT INTO Profesiones_Persona (Profesion, ID_Profesion, ID_Persona) VALUES (2, 2, 2);
INSERT INTO Profesiones_Persona (Profesion, ID_Profesion, ID_Persona) VALUES (3, 3, 3);
INSERT INTO Profesiones_Persona (Profesion, ID_Profesion, ID_Persona) VALUES (4, 4, 4);
INSERT INTO Profesiones_Persona (Profesion, ID_Profesion, ID_Persona) VALUES (5, 5, 5);


-------------------------- Creación de la tabla Tipo_Clientes ---------------------------
CREATE TABLE Tipo_Clientes (
    ID_Tipo_Cliente NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45)
);

----------------------- Inserción de valores en la tabla Tipo_Clientes -------------------------
INSERT INTO Tipo_Clientes (ID_Tipo_Cliente, Descripcion) VALUES (1, 'Cliente Regular');
INSERT INTO Tipo_Clientes (ID_Tipo_Cliente, Descripcion) VALUES (2, 'Cliente VIP');
INSERT INTO Tipo_Clientes (ID_Tipo_Cliente, Descripcion) VALUES (3, 'Cliente Corporativo');
INSERT INTO Tipo_Clientes (ID_Tipo_Cliente, Descripcion) VALUES (4, 'Cliente Nuevo');
INSERT INTO Tipo_Clientes (ID_Tipo_Cliente, Descripcion) VALUES (5, 'Cliente Tercera Edad');


---------------------- Creación de la tabla Beneficios -------------------------
CREATE TABLE Beneficios (
    ID_Beneficio NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    Fecha_Vigencia DATE
);

-------------------------------------------------- Inserción de valores en la tabla Beneficios ------------------------------------------------------------
INSERT INTO Beneficios (ID_Beneficio, Descripcion, Fecha_Vigencia) VALUES (1, 'Descuento del 10% en compras', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Beneficios (ID_Beneficio, Descripcion, Fecha_Vigencia) VALUES (2, 'Acceso exclusivo a eventos', TO_DATE('2023-11-15', 'YYYY-MM-DD'));
INSERT INTO Beneficios (ID_Beneficio, Descripcion, Fecha_Vigencia) VALUES (3, 'Envío gratuito a domicilio', TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Beneficios (ID_Beneficio, Descripcion, Fecha_Vigencia) VALUES (4, 'Asesoría personalizada', TO_DATE('2023-09-20', 'YYYY-MM-DD'));
INSERT INTO Beneficios (ID_Beneficio, Descripcion, Fecha_Vigencia) VALUES (5, 'Regalo sorpresa en la primera compra', TO_DATE('2023-08-10', 'YYYY-MM-DD'));


---------------------------------- Creación de la tabla Beneficios_TipoCliente -------------------------------------
CREATE TABLE Beneficios_TipoCliente (
    ID_BeneficiosTC NUMBER PRIMARY KEY,
    ID_Tipo_Cliente NUMBER,
    ID_Beneficio NUMBER,
    CONSTRAINT FK_ID_Tipo_Cliente FOREIGN KEY (ID_Tipo_Cliente) REFERENCES Tipo_Clientes (ID_Tipo_Cliente),
    CONSTRAINT FK_ID_Beneficio FOREIGN KEY (ID_Beneficio) REFERENCES Beneficios (ID_Beneficio)
);

------------------------ Inserción de valores en la tabla Beneficios_TipoCliente --------------------------
INSERT INTO Beneficios_TipoCliente (ID_BeneficiosTC, ID_Tipo_Cliente, ID_Beneficio) VALUES (1, 1, 1);
INSERT INTO Beneficios_TipoCliente (ID_BeneficiosTC, ID_Tipo_Cliente, ID_Beneficio) VALUES (2, 2, 2);
INSERT INTO Beneficios_TipoCliente (ID_BeneficiosTC, ID_Tipo_Cliente, ID_Beneficio) VALUES (3, 3, 3);
INSERT INTO Beneficios_TipoCliente (ID_BeneficiosTC, ID_Tipo_Cliente, ID_Beneficio) VALUES (4, 4, 4);
INSERT INTO Beneficios_TipoCliente (ID_BeneficiosTC, ID_Tipo_Cliente, ID_Beneficio) VALUES (5, 5, 5);


------------------------------------- Creación de la tabla Clientes ------------------------------------------
CREATE TABLE Clientes (
    ID_Cliente NUMBER PRIMARY KEY,
    ID_Persona NUMBER,
    ID_Tipo_Cliente NUMBER,
    Fecha_Ingreso DATE,
    CONSTRAINT FK_ID_Personas FOREIGN KEY (ID_Persona) REFERENCES Persona (ID_Persona),
    CONSTRAINT FK_ID_Tipo_Client FOREIGN KEY (ID_Tipo_Cliente) REFERENCES Tipo_Clientes (ID_Tipo_Cliente)
);

------------------------------------------- Inserción de valores en la tabla Clientes ------------------------------------------------
INSERT INTO Clientes (ID_Cliente, ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (1, 1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Cliente, ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (2, 2, 2, TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Cliente, ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (3, 3, 3, TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Cliente, ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (4, 4, 4, TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Cliente, ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (5, 5, 5, TO_DATE('2023-05-08', 'YYYY-MM-DD'));


-------------------------------- Creación de la tabla Empleados ------------------------------------
CREATE TABLE Empleados (
    ID_Empleado NUMBER PRIMARY KEY,
    Usuario VARCHAR2(45),
    Password VARCHAR2(45),
    Jornada_Laboral VARCHAR2(45),
    Salario NUMBER,
    Fecha_Ingreso DATE,
    ID_Persona NUMBER,
    CONSTRAINT FK_ID_Person FOREIGN KEY (ID_Persona) REFERENCES Persona (ID_Persona)
);

------------------------------------- Inserción de valores en la tabla Empleados ------------------------------------------
INSERT INTO Empleados (ID_Empleado, Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES (1, 'usuario1', 'contraseña1', 'Lunes a Viernes', 35000, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO Empleados (ID_Empleado, Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES (2, 'usuario2', 'contraseña2', 'Lunes a Sábado', 42000, TO_DATE('2021-11-20', 'YYYY-MM-DD'), 2);
INSERT INTO Empleados (ID_Empleado, Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES (3, 'usuario3', 'contraseña3', 'Martes a Sábado', 38000, TO_DATE('2022-03-10', 'YYYY-MM-DD'), 3);
INSERT INTO Empleados (ID_Empleado, Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES (4, 'usuario4', 'contraseña4', 'Lunes a Viernes', 40000, TO_DATE('2020-04-05', 'YYYY-MM-DD'), 4);
INSERT INTO Empleados (ID_Empleado, Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES (5, 'usuario5', 'contraseña5', 'Miércoles a Domingo', 46000, TO_DATE('2023-02-08', 'YYYY-MM-DD'), 5);


--------------------------- Creación de la tabla Tipo_Empleado -------------------------------
CREATE TABLE Tipo_Empleado (
    ID_Tipo_Empleado NUMBER PRIMARY KEY,
    Tipo VARCHAR2(40),
    ID_Empleado NUMBER,
    CONSTRAINT FK_ID_Empleado FOREIGN KEY (ID_Empleado) REFERENCES Empleados (ID_Empleado)
);

------------------ Inserción de valores en la tabla Tipo_Empleado ---------------------
INSERT INTO Tipo_Empleado (ID_Tipo_Empleado, Tipo, ID_Empleado)
VALUES (1, 'Administrativo', 1);
INSERT INTO Tipo_Empleado (ID_Tipo_Empleado, Tipo, ID_Empleado)
VALUES (2, 'Mantenimiento', 2);
INSERT INTO Tipo_Empleado (ID_Tipo_Empleado, Tipo, ID_Empleado)
VALUES (3, 'Gerente', 3);
INSERT INTO Tipo_Empleado (ID_Tipo_Empleado, Tipo, ID_Empleado)
VALUES (4, 'Administrativo', 4);
INSERT INTO Tipo_Empleado (ID_Tipo_Empleado, Tipo, ID_Empleado)
VALUES (5, 'Mantenimiento', 5);


----------------- Creación de la tabla Factura ---------------------
CREATE TABLE Factura (
    ID_Factura NUMBER PRIMARY KEY,
    Fecha_Emision DATE,
    Impuesto NUMBER,
    Descuento NUMBER,
    CAI VARCHAR2(20),
    Total FLOAT,
    Descripcion VARCHAR2(40)
);

-------------------------------- Inserción de valores en la tabla Factura ------------------------------------
INSERT INTO Factura (ID_Factura, Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion)
VALUES (1, TO_DATE('2023-08-10', 'YYYY-MM-DD'), 15, 5, 'ABCDE12345', 150.50, 'Venta de productos');
INSERT INTO Factura (ID_Factura, Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion)
VALUES (2, TO_DATE('2023-08-11', 'YYYY-MM-DD'), 10, 0, 'FGHIJ67890', 75.00, 'Servicio de consulta');
INSERT INTO Factura (ID_Factura, Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion)
VALUES (3, TO_DATE('2023-08-12', 'YYYY-MM-DD'), 20, 8, 'KLMNO12345', 220.75, 'Compra de medicamentos');
INSERT INTO Factura (ID_Factura, Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion)
VALUES (4, TO_DATE('2023-08-13', 'YYYY-MM-DD'), 5, 2, 'PQRST67890', 45.25, 'Pago de servicios');
INSERT INTO Factura (ID_Factura, Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion)
VALUES (5, TO_DATE('2023-08-14', 'YYYY-MM-DD'), 18, 3, 'UVWXY12345', 320.00, 'Artículos varios');


------------------------------- Creación de la tabla Orden_Pedidos ---------------------------------
CREATE TABLE Orden_Pedidos (
    ID_Orden_Pedidos NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    Fecha DATE,
    Cliente VARCHAR2(45),
    ID_Empleado NUMBER,
    ID_Clientes NUMBER,
    ID_Factura NUMBER,
    CONSTRAINT FK_OP_ID_Clientes FOREIGN KEY (ID_Clientes) REFERENCES Clientes (ID_Cliente),
    CONSTRAINT FK_OP_ID_Empleado FOREIGN KEY (ID_Empleado) REFERENCES Empleados (ID_Empleado),
    CONSTRAINT FK_ID_Factura FOREIGN KEY (ID_Factura) REFERENCES Factura (ID_Factura)
);

-------------------------------- Inserción de valores en la tabla Orden_Pedidos -----------------------------------
INSERT INTO Orden_Pedidos (ID_Orden_Pedidos, Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES (1, 'Pedido de productos', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'Cliente A', 1, 1, 1);
INSERT INTO Orden_Pedidos (ID_Orden_Pedidos, Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES (2, 'Solicitud de servicio', TO_DATE('2023-08-11', 'YYYY-MM-DD'), 'Cliente B', 2, 2, 2);
INSERT INTO Orden_Pedidos (ID_Orden_Pedidos, Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES (3, 'Compra de medicamentos', TO_DATE('2023-08-12', 'YYYY-MM-DD'), 'Cliente C', 3, 3, 3);
INSERT INTO Orden_Pedidos (ID_Orden_Pedidos, Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES (4, 'Pago de servicios', TO_DATE('2023-08-13', 'YYYY-MM-DD'), 'Cliente D', 4, 4, 4);
INSERT INTO Orden_Pedidos (ID_Orden_Pedidos, Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES (5, 'Pedido de artículos varios', TO_DATE('2023-08-14', 'YYYY-MM-DD'), 'Cliente E', 5, 5, 5);


----------------------------------- Creación de la tabla Laboratorios -------------------------------------------
CREATE TABLE Laboratorios (
    ID_Laboratorio NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    ID_Direccion NUMBER,
    CONSTRAINT FK_ID_Direccion_Laboratorio FOREIGN KEY (ID_Direccion) REFERENCES Direccion (ID_Direccion)
);

----------------------- Inserción de valores en la tabla Laboratorios -----------------------
INSERT INTO Laboratorios (ID_Laboratorio, Descripcion, ID_Direccion)
VALUES (1, 'Labcorp', 1);
INSERT INTO Laboratorios (ID_Laboratorio, Descripcion, ID_Direccion)
VALUES (2, 'Labin', 2);
INSERT INTO Laboratorios (ID_Laboratorio, Descripcion, ID_Direccion)
VALUES (3, 'Biomédica', 3);
INSERT INTO Laboratorios (ID_Laboratorio, Descripcion, ID_Direccion)
VALUES (4, 'Pharmatech', 4);
INSERT INTO Laboratorios (ID_Laboratorio, Descripcion, ID_Direccion)
VALUES (5, 'Diagnóstico Molecular', 5);


------------------------------------ Creación de la tabla Droguerias ----------------------------------------
CREATE TABLE Droguerias (
    ID_Drogueria NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    ID_Direccion NUMBER,
    CONSTRAINT FK_ID_Direccion_Drogueria FOREIGN KEY (ID_Direccion) REFERENCES Direccion (ID_Direccion)
);

----------------------- Inserción de valores en la tabla Droguerias --------------------------
INSERT INTO Droguerias (ID_Drogueria, Descripcion, ID_Direccion)
VALUES (1, 'Droguería San Juan', 1);
INSERT INTO Droguerias (ID_Drogueria, Descripcion, ID_Direccion)
VALUES (2, 'Farmacia La Esperanza', 2);
INSERT INTO Droguerias (ID_Drogueria, Descripcion, ID_Direccion)
VALUES (3, 'Droguería Santa María', 3);
INSERT INTO Droguerias (ID_Drogueria, Descripcion, ID_Direccion)
VALUES (4, 'Farmacia El Sol', 4);
INSERT INTO Droguerias (ID_Drogueria, Descripcion, ID_Direccion)
VALUES (5, 'Droguería El Faro', 5);


------------------------------- Creación de la tabla Laboratorios_Drogueria ----------------------------------
CREATE TABLE Laboratorios_Drogueria (
    ID_Laboratorio_Drogueria NUMBER PRIMARY KEY,
    ID_Laboratorio NUMBER,
    ID_Drogueria NUMBER,
    CONSTRAINT FK_ID_Laboratorio_LD FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorios (ID_Laboratorio),
    CONSTRAINT FK_ID_Drogueria_LD FOREIGN KEY (ID_Drogueria) REFERENCES Droguerias (ID_Drogueria)
);

------------------- Inserción de valores en la tabla Laboratorios_Drogueria ----------------------
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio_Drogueria, ID_Laboratorio, ID_Drogueria)
VALUES (1, 1, 1);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio_Drogueria, ID_Laboratorio, ID_Drogueria)
VALUES (2, 2, 2);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio_Drogueria, ID_Laboratorio, ID_Drogueria)
VALUES (3, 3, 3);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio_Drogueria, ID_Laboratorio, ID_Drogueria)
VALUES (4, 4, 4);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio_Drogueria, ID_Laboratorio, ID_Drogueria)
VALUES (5, 5, 5);


--------------------------------- Creación de la tabla Productos -----------------------------------------
CREATE TABLE Productos (
    ID_Producto NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    Nombre_Producto VARCHAR2(45),
    Fecha_Vencimiento DATE,
    Fecha_Laboracion DATE,
    Prohibiciones VARCHAR2(45),
    Existencias NUMBER,
    ID_Drogueria NUMBER,
    CONSTRAINT FK_ID_Drogueria_Producto FOREIGN KEY (ID_Drogueria) REFERENCES Droguerias (ID_Drogueria)
);

---------------------------------------------------------- Inserción de valores en la tabla Productos ----------------------------------------------------------------
INSERT INTO Productos (ID_Producto, Descripcion, Nombre_Producto, Fecha_Vencimiento, Fecha_Laboracion, Prohibiciones, Existencias, ID_Drogueria)
VALUES (1, 'Analgésico', 'Paracetamol', TO_DATE('2023-12-31', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'No usar en caso de alergia', 100, 1);
INSERT INTO Productos (ID_Producto, Descripcion, Nombre_Producto, Fecha_Vencimiento, Fecha_Laboracion, Prohibiciones, Existencias, ID_Drogueria)
VALUES (2, 'Antibiótico', 'Amoxicilina', TO_DATE('2023-11-30', 'YYYY-MM-DD'), TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'Solo con prescripción médica', 50, 2);
INSERT INTO Productos (ID_Producto, Descripcion, Nombre_Producto, Fecha_Vencimiento, Fecha_Laboracion, Prohibiciones, Existencias, ID_Drogueria)
VALUES (3, 'Antiinflamatorio', 'Ibuprofeno', TO_DATE('2023-10-15', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'No exceder la dosis recomendada', 75, 3);
INSERT INTO Productos (ID_Producto, Descripcion, Nombre_Producto, Fecha_Vencimiento, Fecha_Laboracion, Prohibiciones, Existencias, ID_Drogueria)
VALUES (4, 'Vitamina', 'Vitamina C', TO_DATE('2023-09-30', 'YYYY-MM-DD'), TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'No sustituye una dieta balanceada', 200, 4);
INSERT INTO Productos (ID_Producto, Descripcion, Nombre_Producto, Fecha_Vencimiento, Fecha_Laboracion, Prohibiciones, Existencias, ID_Drogueria)
VALUES (5, 'Antialérgico', 'Loratadina', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-04-25', 'YYYY-MM-DD'), 'Consultar con el médico', 30, 5);


---------------------------- Creación de la tabla Productos_Droguerias ---------------------------------------
CREATE TABLE Productos_Droguerias (
    ID_Producto_Drogueria NUMBER PRIMARY KEY,
    ID_Producto NUMBER,
    ID_Drogueria NUMBER,
    CONSTRAINT FK_ID_Droguerias_PD FOREIGN KEY (ID_Drogueria) REFERENCES Droguerias (ID_Drogueria),
    CONSTRAINT FK_ID_Productos_PD FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto)
);

---------------------- Inserción de valores en la tabla Productos_Droguerias ------------------------
INSERT INTO Productos_Droguerias (ID_Producto_Drogueria, ID_Producto, ID_Drogueria) VALUES (1, 1, 1);
INSERT INTO Productos_Droguerias (ID_Producto_Drogueria, ID_Producto, ID_Drogueria) VALUES (2, 2, 2);
INSERT INTO Productos_Droguerias (ID_Producto_Drogueria, ID_Producto, ID_Drogueria) VALUES (3, 3, 3);
INSERT INTO Productos_Droguerias (ID_Producto_Drogueria, ID_Producto, ID_Drogueria) VALUES (4, 4, 4);
INSERT INTO Productos_Droguerias (ID_Producto_Drogueria, ID_Producto, ID_Drogueria) VALUES (5, 5, 5);


-------------------- Creación de la tabla Tipo_Medicamento ---------------------
CREATE TABLE Tipo_Medicamento (
    ID_Tipo_Medicamento NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45)
);

--------------------- Inserción de valores en la tabla Tipo_Medicamento ---------------------
INSERT INTO Tipo_Medicamento (ID_Tipo_Medicamento, Descripcion) VALUES (1, 'Analgésico');
INSERT INTO Tipo_Medicamento (ID_Tipo_Medicamento, Descripcion) VALUES (2, 'Antibiótico');
INSERT INTO Tipo_Medicamento (ID_Tipo_Medicamento, Descripcion) VALUES (3, 'Antiinflamatorio');
INSERT INTO Tipo_Medicamento (ID_Tipo_Medicamento, Descripcion) VALUES (4, 'Vitamina');
INSERT INTO Tipo_Medicamento (ID_Tipo_Medicamento, Descripcion) VALUES (5, 'Antialérgico');


-------------------------------------------- Creación de la tabla Medicamento ----------------------------------------------------
CREATE TABLE Medicamento (
    ID_Medicamentos NUMBER PRIMARY KEY,
    Nombre_Medicamento VARCHAR2(45),
    No_Lote VARCHAR2(45),
    ID_Producto NUMBER,
    ID_Tipo_Medicamento NUMBER,
    CONSTRAINT FK_ID_Productos FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto),
    CONSTRAINT FK_ID_Tipo_Medicamento FOREIGN KEY (ID_Tipo_Medicamento) REFERENCES Tipo_Medicamento (ID_Tipo_Medicamento)
);
 
---------------------------- Inserción de valores en la tabla Medicamento ---------------------------------
INSERT INTO Medicamento (ID_Medicamentos, Nombre_Medicamento, No_Lote, ID_Producto, ID_Tipo_Medicamento)
VALUES (1, 'Paracetamol', 'A12345', 1, 1);
INSERT INTO Medicamento (ID_Medicamentos, Nombre_Medicamento, No_Lote, ID_Producto, ID_Tipo_Medicamento)
VALUES (2, 'Amoxicilina', 'B67890', 2, 2);
INSERT INTO Medicamento (ID_Medicamentos, Nombre_Medicamento, No_Lote, ID_Producto, ID_Tipo_Medicamento)
VALUES (3, 'Ibuprofeno', 'C54321', 3, 3);
INSERT INTO Medicamento (ID_Medicamentos, Nombre_Medicamento, No_Lote, ID_Producto, ID_Tipo_Medicamento)
VALUES (4, 'Vitamina C', 'D98765', 4, 4);
INSERT INTO Medicamento (ID_Medicamentos, Nombre_Medicamento, No_Lote, ID_Producto, ID_Tipo_Medicamento)
VALUES (5, 'Loratadina', 'E24680', 5, 5);


--------------------------------- Creación de la tabla Suplementos -------------------------------------------
CREATE TABLE Suplementos (
    ID_Suplementos NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    ID_Producto NUMBER,
    CONSTRAINT FK_ID_Productos_Suplementos FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto)
);

----------------------------- Inserción de valores en la tabla Suplementos -----------------------------------
INSERT INTO Suplementos (ID_Suplementos, Descripcion, ID_Producto) VALUES (1, 'Calcio y Vitamina D', 1);
INSERT INTO Suplementos (ID_Suplementos, Descripcion, ID_Producto) VALUES (2, 'Hierro y Ácido Fólico', 2);
INSERT INTO Suplementos (ID_Suplementos, Descripcion, ID_Producto) VALUES (3, 'Omega-3', 3);
INSERT INTO Suplementos (ID_Suplementos, Descripcion, ID_Producto) VALUES (4, 'Proteína en Polvo', 4);
INSERT INTO Suplementos (ID_Suplementos, Descripcion, ID_Producto) VALUES (5, 'Multivitamínico', 5);


---------------------- Creación de la tabla Restricciones ----------------------
CREATE TABLE Restricciones (
    ID_Restricciones NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45)
);

------------------------ Inserción de valores en la tabla Restricciones ----------------------------
INSERT INTO Restricciones (ID_Restricciones, Descripcion) VALUES (1, 'Alergia a la lactosa');
INSERT INTO Restricciones (ID_Restricciones, Descripcion) VALUES (2, 'Hipertensión');
INSERT INTO Restricciones (ID_Restricciones, Descripcion) VALUES (3, 'Diabetes');
INSERT INTO Restricciones (ID_Restricciones, Descripcion) VALUES (4, 'Alergia al gluten');
INSERT INTO Restricciones (ID_Restricciones, Descripcion) VALUES (5, 'Intolerancia a la cafeína');


------------------------------------ Creación de la tabla Restriccion_Productos -----------------------------------------
CREATE TABLE Restriccion_Productos (
    ID_Restricciones_Productos NUMBER PRIMARY KEY,
    ID_Restricciones NUMBER,
    ID_Producto NUMBER,
    CONSTRAINT FK_ID_Productos_RP FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto),
    CONSTRAINT FK_ID_Restricciones_RP FOREIGN KEY (ID_Restricciones) REFERENCES Restricciones (ID_Restricciones)
);

----------------------------- Inserción de valores en la tabla Restriccion_Productos -----------------------------
INSERT INTO Restriccion_Productos (ID_Restricciones_Productos, ID_Restricciones, ID_Producto) VALUES (1, 1, 1);
INSERT INTO Restriccion_Productos (ID_Restricciones_Productos, ID_Restricciones, ID_Producto) VALUES (2, 2, 2);
INSERT INTO Restriccion_Productos (ID_Restricciones_Productos, ID_Restricciones, ID_Producto) VALUES (3, 3, 3);
INSERT INTO Restriccion_Productos (ID_Restricciones_Productos, ID_Restricciones, ID_Producto) VALUES (4, 4, 4);
INSERT INTO Restriccion_Productos (ID_Restricciones_Productos, ID_Restricciones, ID_Producto) VALUES (5, 5, 5);


---------------- Creación de la tabla Forma_Administracion ----------------
CREATE TABLE Forma_Administracion (
    ID_Forma_Administracion NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45),
    Formas_Administracion VARCHAR2(45)
);

------------------------------------------- Inserción de valores en la tabla Forma_Administracion ----------------------------------------
INSERT INTO Forma_Administracion (ID_Forma_Administracion, Descripcion, Formas_Administracion) VALUES (1, 'Tableta', 'Oral');
INSERT INTO Forma_Administracion (ID_Forma_Administracion, Descripcion, Formas_Administracion) VALUES (2, 'Cápsula', 'Oral');
INSERT INTO Forma_Administracion (ID_Forma_Administracion, Descripcion, Formas_Administracion) VALUES (3, 'Jarabe', 'Oral');
INSERT INTO Forma_Administracion (ID_Forma_Administracion, Descripcion, Formas_Administracion) VALUES (4, 'Inyección', 'Intramuscular');
INSERT INTO Forma_Administracion (ID_Forma_Administracion, Descripcion, Formas_Administracion) VALUES (5, 'Parche', 'Transdérmico');


---------------------------------------------- Creación de la tabla Formas_Adm_Productos ------------------------------------------------------
CREATE TABLE Formas_Adm_Productos (
    ID_Formas_AdmProductos NUMBER PRIMARY KEY,
    ID_Producto NUMBER,
    ID_Forma_Administracion NUMBER,
    CONSTRAINT FK_ID_Producto_F_ADM_P FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto),
    CONSTRAINT FK_ID_Forma_Administracion FOREIGN KEY (ID_Forma_Administracion) REFERENCES Forma_Administracion (ID_Forma_Administracion)
);

-------------------------------- Inserción de valores en la tabla Formas_Adm_Productos -----------------------------------
INSERT INTO Formas_Adm_Productos (ID_Formas_AdmProductos, ID_Producto, ID_Forma_Administracion) VALUES (1, 1, 1);
INSERT INTO Formas_Adm_Productos (ID_Formas_AdmProductos, ID_Producto, ID_Forma_Administracion) VALUES (2, 2, 2);
INSERT INTO Formas_Adm_Productos (ID_Formas_AdmProductos, ID_Producto, ID_Forma_Administracion) VALUES (3, 3, 3);
INSERT INTO Formas_Adm_Productos (ID_Formas_AdmProductos, ID_Producto, ID_Forma_Administracion) VALUES (4, 4, 4);
INSERT INTO Formas_Adm_Productos (ID_Formas_AdmProductos, ID_Producto, ID_Forma_Administracion) VALUES (5, 5, 5);


---------------------------- Creación de la tabla Factura_Producto ----------------------------------
CREATE TABLE Factura_Producto (
    ID_Factura_Productos NUMBER PRIMARY KEY,
    ID_Factura NUMBER,
    ID_Producto NUMBER,
    CONSTRAINT FK_ID_Factura_FP FOREIGN KEY (ID_Factura) REFERENCES Factura (ID_Factura),
    CONSTRAINT FK_ID_Productos_FP FOREIGN KEY (ID_Producto) REFERENCES Productos (ID_Producto)
);

---------------------- Inserción de valores en la tabla Factura_Producto -----------------------
INSERT INTO Factura_Producto (ID_Factura_Productos, ID_Factura, ID_Producto) VALUES (1, 1, 1);
INSERT INTO Factura_Producto (ID_Factura_Productos, ID_Factura, ID_Producto) VALUES (2, 2, 2);
INSERT INTO Factura_Producto (ID_Factura_Productos, ID_Factura, ID_Producto) VALUES (3, 3, 3);
INSERT INTO Factura_Producto (ID_Factura_Productos, ID_Factura, ID_Producto) VALUES (4, 4, 4);
INSERT INTO Factura_Producto (ID_Factura_Productos, ID_Factura, ID_Producto) VALUES (5, 5, 5);


--------------- Creación de la tabla Formas_Pagos ----------------------
CREATE TABLE Formas_Pagos (
    ID_Formas_Pago NUMBER PRIMARY KEY,
    Descripcion VARCHAR2(45)
);

------------------------ Inserción de valores en la tabla Formas_Pagos ---------------------------
INSERT INTO Formas_Pagos (ID_Formas_Pago, Descripcion) VALUES (1, 'Efectivo');
INSERT INTO Formas_Pagos (ID_Formas_Pago, Descripcion) VALUES (2, 'Tarjeta de Crédito');
INSERT INTO Formas_Pagos (ID_Formas_Pago, Descripcion) VALUES (3, 'Tarjeta de Débito');
INSERT INTO Formas_Pagos (ID_Formas_Pago, Descripcion) VALUES (4, 'Transferencia Bancaria');
INSERT INTO Formas_Pagos (ID_Formas_Pago, Descripcion) VALUES (5, 'Cheque');


------------------------------- Creación de la tabla Factura_FormaPagos -------------------------------------
CREATE TABLE Factura_FormaPagos (
    ID_Factura_FormaPago NUMBER PRIMARY KEY,
    ID_Factura NUMBER,
    ID_Formas_Pago NUMBER,
    CONSTRAINT FK_ID_Factura_FF FOREIGN KEY (ID_Factura) REFERENCES Factura (ID_Factura),
    CONSTRAINT FK_ID_Formas_Pago_FF FOREIGN KEY (ID_Formas_Pago) REFERENCES Formas_Pagos (ID_Formas_Pago)
);

------------------------- Inserción de valores en la tabla Factura_FormaPagos ----------------------------
INSERT INTO Factura_FormaPagos (ID_Factura_FormaPago, ID_Factura, ID_Formas_Pago) VALUES (1, 1, 1);
INSERT INTO Factura_FormaPagos (ID_Factura_FormaPago, ID_Factura, ID_Formas_Pago) VALUES (2, 2, 2);
INSERT INTO Factura_FormaPagos (ID_Factura_FormaPago, ID_Factura, ID_Formas_Pago) VALUES (3, 3, 3);
INSERT INTO Factura_FormaPagos (ID_Factura_FormaPago, ID_Factura, ID_Formas_Pago) VALUES (4, 4, 4);
INSERT INTO Factura_FormaPagos (ID_Factura_FormaPago, ID_Factura, ID_Formas_Pago) VALUES (5, 5, 5);