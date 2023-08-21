CREATE TABLE Pais (
    ID_Pais NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

--------------- Inserción de valores en la tabla Pais ---------------------
INSERT INTO Pais (Descripcion) VALUES ('Honduras');
INSERT INTO Pais (Descripcion) VALUES ('El Salvador');
INSERT INTO Pais (Descripcion) VALUES ('Nicaragua');
INSERT INTO Pais (Descripcion) VALUES ('Panama');
INSERT INTO Pais (Descripcion) VALUES ('Guatemala');


---------------------- Creación de la tabla Departamento -----------------------
CREATE TABLE Departamento (
    ID_Departamento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Pais NUMBER NOT NULL,
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
    Ciudad VARCHAR2(1) NOT NULL,
    ID_Departamento NUMBER NOT NULL,
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
    Descripcion VARCHAR2(45) NOT NULL,
    ID_Municipio NUMBER NOT NULL,
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
    Descripcion VARCHAR2(45) NOT NULL,
    GPS VARCHAR2(45),
    ID_Colonia NUMBER NOT NULL,
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
    ID_Profesion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

------------------------- Inserción de valores en la tabla Profesiones ---------------------------
INSERT INTO Profesiones (Descripcion) VALUES ('Ingeniero');
INSERT INTO Profesiones (Descripcion) VALUES ('Médico');
INSERT INTO Profesiones (Descripcion) VALUES ('Abogado');
INSERT INTO Profesiones (Descripcion) VALUES ('Profesor');
INSERT INTO Profesiones (Descripcion) VALUES ('Arquitecto');

SELECT * FROM Profesiones


------------------------------- Creación de la tabla Profesiones -----------------------------------
CREATE TABLE Persona (
    ID_Persona NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    P_Nombre VARCHAR2(45) NOT NULL,
    S_Nombre VARCHAR2(45),
    P_Apellido VARCHAR2(45) NOT NULL,
    S_Apellido VARCHAR2(45) NOT NULL,
    Genero VARCHAR(1) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Correo VARCHAR2(45) NOT NULL,
    Celular NUMBER NOT NULL,
    ID_Direccion NUMBER NOT NULL,
    CONSTRAINT FK_ID_Direccion FOREIGN KEY (ID_Direccion) REFERENCES Direccion (ID_Direccion)
);

----------------------------- Creación de índices -----------------------------------
CREATE INDEX IX_Persona_Correo ON Persona (Correo);
CREATE INDEX IX_Persona_Fecha_Nacimiento ON Persona (Fecha_Nacimiento);

------------------------------------------ Inserción de valores en la tabla Persona -------------------------------------------------------
INSERT INTO Persona (P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES ('Juan', 'Carlos', 'Pérez', 'García', 'M', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'juan@example.com', 99887766, 1);
INSERT INTO Persona (P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES ('María', 'Elena', 'López', 'Rodríguez', 'F', TO_DATE('1985-11-20', 'YYYY-MM-DD'), 'maria@example.com', 98765432, 2);
INSERT INTO Persona (P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES ('Carlos', 'Andrés', 'Martínez', 'Pérez', 'M', TO_DATE('1995-03-10', 'YYYY-MM-DD'), 'carlos@example.com', 87654321, 3);
INSERT INTO Persona (P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES ('Ana', 'Isabel', 'Ramírez', 'Hernández', 'F', TO_DATE('1982-07-08', 'YYYY-MM-DD'), 'ana@example.com', 76543210, 4);
INSERT INTO Persona (P_Nombre, S_Nombre, P_Apellido, S_Apellido, Genero, Fecha_Nacimiento, Correo, Celular, ID_Direccion)
VALUES ('Luis', 'Alberto', 'González', 'Gómez', 'M', TO_DATE('1998-09-25', 'YYYY-MM-DD'), 'luis@example.com', 65432109, 5);


---------------------------- Creación de la tabla Profesiones_Persona --------------------------------
CREATE TABLE Profesiones_Persona (
    Profesion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Profesion NUMBER NOT NULL,
    ID_Persona NUMBER NOT NULL,
    CONSTRAINT FK_ID_Profesion FOREIGN KEY (ID_Profesion) REFERENCES Profesiones (ID_Profesion),
    CONSTRAINT FK_ID_Persona FOREIGN KEY (ID_Persona) REFERENCES Persona (ID_Persona)
);

---------------------- Inserción de valores en la tabla Profesiones_Persona -------------------------
INSERT INTO Profesiones_Persona (ID_Profesion, ID_Persona) VALUES (1, 1);
INSERT INTO Profesiones_Persona (ID_Profesion, ID_Persona) VALUES (2, 2);
INSERT INTO Profesiones_Persona (ID_Profesion, ID_Persona) VALUES (3, 3);
INSERT INTO Profesiones_Persona (ID_Profesion, ID_Persona) VALUES (4, 4);
INSERT INTO Profesiones_Persona (ID_Profesion, ID_Persona) VALUES (5, 5);


-------------------------- Creación de la tabla Tipo_Clientes ---------------------------
CREATE TABLE Tipo_Clientes (
    ID_Tipo_Cliente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

----------------------- Inserción de valores en la tabla Tipo_Clientes -------------------------
INSERT INTO Tipo_Clientes ( Descripcion) VALUES ('Cliente Regular');
INSERT INTO Tipo_Clientes ( Descripcion) VALUES ('Cliente VIP');
INSERT INTO Tipo_Clientes ( Descripcion) VALUES ('Cliente Corporativo');
INSERT INTO Tipo_Clientes (Descripcion) VALUES ('Cliente Nuevo');
INSERT INTO Tipo_Clientes (Descripcion) VALUES ('Cliente Tercera Edad');



---------------------- Creación de la tabla Beneficios -------------------------
CREATE TABLE Beneficios (
    ID_Beneficio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL,
    Fecha_Vigencia DATE NOT NULL
);

-------------------------------------------------- Inserción de valores en la tabla Beneficios ------------------------------------------------------------
INSERT INTO Beneficios ( Descripcion, Fecha_Vigencia) VALUES ('Descuento del 10% en compras', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Beneficios ( Descripcion, Fecha_Vigencia) VALUES ('Acceso exclusivo a eventos', TO_DATE('2023-11-15', 'YYYY-MM-DD'));
INSERT INTO Beneficios (Descripcion, Fecha_Vigencia) VALUES ('Envío gratuito a domicilio', TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Beneficios (Descripcion, Fecha_Vigencia) VALUES ('Asesoría personalizada', TO_DATE('2023-09-20', 'YYYY-MM-DD'));
INSERT INTO Beneficios ( Descripcion, Fecha_Vigencia) VALUES ('Regalo sorpresa en la primera compra', TO_DATE('2023-08-10', 'YYYY-MM-DD'));


---------------------------------- Creación de la tabla Beneficios_TipoCliente -------------------------------------
CREATE TABLE Beneficios_TipoCliente (
    ID_BeneficiosTC NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Tipo_Cliente NUMBER NOT NULL,
    ID_Beneficio NUMBER NOT NULL,
    CONSTRAINT FK_ID_Tipo_Cliente FOREIGN KEY (ID_Tipo_Cliente) REFERENCES Tipo_Clientes (ID_Tipo_Cliente),
    CONSTRAINT FK_ID_Beneficio FOREIGN KEY (ID_Beneficio) REFERENCES Beneficios (ID_Beneficio)
);

------------------------ Inserción de valores en la tabla Beneficios_TipoCliente --------------------------
INSERT INTO Beneficios_TipoCliente (ID_Tipo_Cliente, ID_Beneficio) VALUES (1, 1);
INSERT INTO Beneficios_TipoCliente (ID_Tipo_Cliente, ID_Beneficio) VALUES (2, 2);
INSERT INTO Beneficios_TipoCliente (ID_Tipo_Cliente, ID_Beneficio) VALUES (3, 3);
INSERT INTO Beneficios_TipoCliente (ID_Tipo_Cliente, ID_Beneficio) VALUES (4, 4);
INSERT INTO Beneficios_TipoCliente (ID_Tipo_Cliente, ID_Beneficio) VALUES (5, 5);


------------------------------------- Creación de la tabla Clientes ------------------------------------------
CREATE TABLE Clientes (
    ID_Cliente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Persona NUMBER NOT NULL,
    ID_Tipo_Cliente NUMBER NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    CONSTRAINT FK_ID_Personas FOREIGN KEY (ID_Persona) REFERENCES Persona (ID_Persona),
    CONSTRAINT FK_ID_Tipo_Client FOREIGN KEY (ID_Tipo_Cliente) REFERENCES Tipo_Clientes (ID_Tipo_Cliente)
);

------------------------------------------- Inserción de valores en la tabla Clientes ------------------------------------------------
INSERT INTO Clientes (ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (2, 2, TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (3, 3, TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (4, 4, TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO Clientes (ID_Persona, ID_Tipo_Cliente, Fecha_Ingreso) VALUES (5, 5, TO_DATE('2023-05-08', 'YYYY-MM-DD'));


-------------------------------- Creación de la tabla Empleados ------------------------------------
CREATE TABLE Empleados (
    ID_Empleado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Usuario VARCHAR2(45) NOT NULL,
    Password VARCHAR2(45) NOT NULL,
    Jornada_Laboral VARCHAR2(45) NOT NULL,
    Salario NUMBER NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    ID_Persona NUMBER NOT NULL,
    CONSTRAINT FK_ID_Person FOREIGN KEY (ID_Persona) REFERENCES Persona (ID_Persona)
);

------------------------------------- Inserción de valores en la tabla Empleados ------------------------------------------
INSERT INTO Empleados (Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES ('usuario1', 'contraseña1', 'Lunes a Viernes', 35000, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO Empleados (Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES ('usuario2', 'contraseña2', 'Lunes a Sábado', 42000, TO_DATE('2021-11-20', 'YYYY-MM-DD'), 2);
INSERT INTO Empleados (Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES ('usuario3', 'contraseña3', 'Martes a Sábado', 38000, TO_DATE('2022-03-10', 'YYYY-MM-DD'), 3);
INSERT INTO Empleados (Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES ('usuario4', 'contraseña4', 'Lunes a Viernes', 40000, TO_DATE('2020-04-05', 'YYYY-MM-DD'), 4);
INSERT INTO Empleados (Usuario, Password, Jornada_Laboral, Salario, Fecha_Ingreso, ID_Persona)
VALUES ('usuario5', 'contraseña5', 'Miércoles a Domingo', 46000, TO_DATE('2023-02-08', 'YYYY-MM-DD'), 5);


--------------------------- Creación de la tabla Tipo_Empleado -------------------------------
CREATE TABLE Tipo_Empleado (
    ID_Tipo_Empleado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Tipo VARCHAR2(40) NOT NULL,
    ID_Empleado NUMBER NOT NULL,
    CONSTRAINT FK_ID_Empleado FOREIGN KEY (ID_Empleado) REFERENCES Empleados (ID_Empleado)
);

------------------ Inserción de valores en la tabla Tipo_Empleado ---------------------
INSERT INTO Tipo_Empleado (Tipo, ID_Empleado)
VALUES ('Administrativo', 1);
INSERT INTO Tipo_Empleado ( Tipo, ID_Empleado)
VALUES ('Mantenimiento', 2);
INSERT INTO Tipo_Empleado (Tipo, ID_Empleado)
VALUES ('Gerente', 3);
INSERT INTO Tipo_Empleado (Tipo, ID_Empleado)
VALUES ('Administrativo', 4);
INSERT INTO Tipo_Empleado (Tipo, ID_Empleado)
VALUES ('Mantenimiento', 5);


----------------- Creación de la tabla Factura ---------------------
CREATE TABLE Factura (
    ID_Factura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Fecha_Emision DATE NOT NULL,
    Impuesto NUMBER NOT NULL,
    Descuento NUMBER,
    CAI VARCHAR2(20),
    Total FLOAT NOT NULL,
    Descripcion VARCHAR2(40),
    ID_Empleado NUMBER NOT NULL,
    ID_Cliente NUMBER NOT NULL,
    CONSTRAINT FKE_ID_Empleado FOREIGN KEY (ID_Empleado) REFERENCES Empleados (ID_Empleado),
    CONSTRAINT FKC_ID_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Clientes (ID_Cliente)
);

-------------------------------- Inserción de valores en la tabla Factura ------------------------------------
INSERT INTO Factura (Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion, ID_Empleado, ID_Cliente)
VALUES (TO_DATE('2023-08-10', 'YYYY-MM-DD'), 15, 5, 'ABCDE12345', 150.50, 'Venta de productos', 4, 2);
INSERT INTO Factura (Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion, ID_Empleado, ID_Cliente)
VALUES (TO_DATE('2023-08-11', 'YYYY-MM-DD'), 10, 0, 'FGHIJ67890', 75.00, 'Servicio de consulta',3, 1);
INSERT INTO Factura (Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion, ID_Empleado,ID_Cliente)
VALUES (TO_DATE('2023-08-12', 'YYYY-MM-DD'), 20, 8, 'KLMNO12345', 220.75, 'Compra de medicamentos', 2, 5);
INSERT INTO Factura (Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion, ID_Empleado, ID_Cliente)
VALUES (TO_DATE('2023-08-13', 'YYYY-MM-DD'), 5, 2, 'PQRST67890', 45.25, 'Pago de servicios', 1, 3);
INSERT INTO Factura (Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion, ID_Empleado,ID_Cliente)
VALUES (TO_DATE('2023-08-14', 'YYYY-MM-DD'), 18, 3, 'UVWXY12345', 320.00, 'Artículos varios', 5, 4);


------------------------------- Creación de la tabla Orden_Pedidos ---------------------------------
CREATE TABLE Orden_Pedidos (
    ID_Orden_Pedidos NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL,
    Fecha DATE NOT NULL,
    Cliente VARCHAR2(45) NOT NULL,
    ID_Empleado NUMBER NOT NULL,
    ID_Clientes NUMBER NOT NULL,
    ID_Factura NUMBER NOT NULL,
    CONSTRAINT FK_OP_ID_Clientes FOREIGN KEY (ID_Clientes) REFERENCES Clientes (ID_Cliente),
    CONSTRAINT FK_OP_ID_Empleado FOREIGN KEY (ID_Empleado) REFERENCES Empleados (ID_Empleado),
    CONSTRAINT FK_ID_Factura FOREIGN KEY (ID_Factura) REFERENCES Factura (ID_Factura)
);

-------------------------------- Inserción de valores en la tabla Orden_Pedidos -----------------------------------
INSERT INTO Orden_Pedidos (Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES ('Pedido de productos', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'Cliente A', 1, 1, 1);
INSERT INTO Orden_Pedidos (Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES ('Solicitud de servicio', TO_DATE('2023-08-11', 'YYYY-MM-DD'), 'Cliente B', 2, 2, 2);
INSERT INTO Orden_Pedidos (Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES ('Compra de medicamentos', TO_DATE('2023-08-12', 'YYYY-MM-DD'), 'Cliente C', 3, 3, 3);
INSERT INTO Orden_Pedidos (Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES ('Pago de servicios', TO_DATE('2023-08-13', 'YYYY-MM-DD'), 'Cliente D', 4, 4, 4);
INSERT INTO Orden_Pedidos (Descripcion, Fecha, Cliente, ID_Empleado, ID_Clientes, ID_Factura)
VALUES ('Pedido de artículos varios', TO_DATE('2023-08-14', 'YYYY-MM-DD'), 'Cliente E', 5, 5, 5);


----------------------------------- Creación de la tabla Laboratorios -------------------------------------------
CREATE TABLE Laboratorios (
    ID_Laboratorio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL,
    ID_Direccion NUMBER NOT NULL,
    CONSTRAINT FK_ID_Direccion_Laboratorio FOREIGN KEY (ID_Direccion) REFERENCES Direccion (ID_Direccion)
);

----------------------- Inserción de valores en la tabla Laboratorios -----------------------
INSERT INTO Laboratorios (Descripcion, ID_Direccion) VALUES ('Labcorp', 1);
INSERT INTO Laboratorios (Descripcion, ID_Direccion) VALUES ('Labin', 2);
INSERT INTO Laboratorios (Descripcion, ID_Direccion) VALUES ('Biomédica', 3);
INSERT INTO Laboratorios (Descripcion, ID_Direccion) VALUES ('Pharmatech', 4);
INSERT INTO Laboratorios (Descripcion, ID_Direccion) VALUES ('Diagnóstico Molecular', 5);


------------------------------------ Creación de la tabla Droguerias ----------------------------------------
CREATE TABLE Droguerias (
    ID_Drogueria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL,
    ID_Direccion NUMBER NOT NULL,
    CONSTRAINT FK_ID_Direccion_Drogueria FOREIGN KEY (ID_Direccion) REFERENCES Direccion (ID_Direccion)
);

----------------------- Inserción de valores en la tabla Droguerias --------------------------
INSERT INTO Droguerias (Descripcion, ID_Direccion) VALUES ('Droguería San Juan', 1);
INSERT INTO Droguerias (Descripcion, ID_Direccion) VALUES ('Farmacia La Esperanza', 2);
INSERT INTO Droguerias (Descripcion, ID_Direccion) VALUES ('Droguería Santa María', 3);
INSERT INTO Droguerias (Descripcion, ID_Direccion) VALUES ('Farmacia El Sol', 4);
INSERT INTO Droguerias (Descripcion, ID_Direccion) VALUES ('Droguería El Faro', 5);


------------------------------- Creación de la tabla Laboratorios_Drogueria ----------------------------------
CREATE TABLE Laboratorios_Drogueria (
    ID_Laboratorio_Drogueria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Laboratorio NUMBER NOT NULL,
    ID_Drogueria NUMBER NOT NULL,
    CONSTRAINT FK_ID_Laboratorio_LD FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorios (ID_Laboratorio),
    CONSTRAINT FK_ID_Drogueria_LD FOREIGN KEY (ID_Drogueria) REFERENCES Droguerias (ID_Drogueria)
);

------------------- Inserción de valores en la tabla Laboratorios_Drogueria ----------------------
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio, ID_Drogueria) VALUES (1, 1);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio, ID_Drogueria) VALUES (2, 2);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio, ID_Drogueria) VALUES (3, 3);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio, ID_Drogueria) VALUES (4, 4);
INSERT INTO Laboratorios_Drogueria (ID_Laboratorio, ID_Drogueria) VALUES (5, 5);


--------------------------------- Creación de la tabla Productos -----------------------------------------


CREATE TABLE Productos_Detalle (
    ID_Producto NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ID_Orden_Pedidos NUMBER,
    ID_Tipo_Medicamento NUMBER,
    Cantidad NUMBER,
    CONSTRAINT FK_ID_Orden_Pedidos FOREIGN KEY (ID_Orden_Pedidos) REFERENCES Orden_Pedidos (ID_Orden_Pedidos),
    CONSTRAINT FK_ID_Tipo_Medicamento_PD FOREIGN KEY (ID_Tipo_Medicamento) REFERENCES Tipo_Medicamento (ID_Tipo_Medicamento)
);


INSERT INTO Productos_Detalle (ID_Orden_Pedidos, ID_Tipo_Medicamento, Cantidad)
VALUES (1, 1, 5);
INSERT INTO Productos_Detalle (ID_Orden_Pedidos, ID_Tipo_Medicamento, Cantidad)
VALUES (2, 2, 2);
INSERT INTO Productos_Detalle (ID_Orden_Pedidos, ID_Tipo_Medicamento, Cantidad)
VALUES (3, 3, 4);
INSERT INTO Productos_Detalle (ID_Orden_Pedidos, ID_Tipo_Medicamento, Cantidad)
VALUES (4, 4, 1);
INSERT INTO Productos_Detalle (ID_Orden_Pedidos, ID_Tipo_Medicamento, Cantidad)
VALUES (5, 5, 3);
INSERT INTO Productos_Detalle (ID_Orden_Pedidos, ID_Tipo_Medicamento, Cantidad) VALUES (1, 1, 2);







---------------------------- Creación de la tabla Productos_Droguerias ---------------------------------------
CREATE TABLE Productos_Droguerias (
    ID_Producto_Drogueria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Producto NUMBER NOT NULL,
    ID_Drogueria NUMBER NOT NULL,
    CONSTRAINT FK_ID_Droguerias_PD FOREIGN KEY (ID_Drogueria) REFERENCES Droguerias (ID_Drogueria),
    CONSTRAINT FK_ID_Productos_PD FOREIGN KEY (ID_Producto) REFERENCES Productos_Detalle (ID_Producto)
);

---------------------- Inserción de valores en la tabla Productos_Droguerias ------------------------
INSERT INTO Productos_Droguerias (ID_Producto, ID_Drogueria) VALUES (1, 1);
INSERT INTO Productos_Droguerias (ID_Producto, ID_Drogueria) VALUES (2, 2);
INSERT INTO Productos_Droguerias (ID_Producto, ID_Drogueria) VALUES (3, 3);
INSERT INTO Productos_Droguerias (ID_Producto, ID_Drogueria) VALUES (4, 4);
INSERT INTO Productos_Droguerias (ID_Producto, ID_Drogueria) VALUES (5, 5);


 
-------------------- Creación de la tabla Tipo_Medicamento ---------------------
CREATE TABLE Tipo_Medicamento (
    ID_Tipo_Medicamento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

--------------------- Inserción de valores en la tabla Tipo_Medicamento ---------------------
INSERT INTO Tipo_Medicamento (Descripcion) VALUES ('Analgésico');
INSERT INTO Tipo_Medicamento ( Descripcion) VALUES ('Antibiótico');
INSERT INTO Tipo_Medicamento (Descripcion) VALUES ('Antiinflamatorio');
INSERT INTO Tipo_Medicamento (Descripcion) VALUES ('Vitamina');
INSERT INTO Tipo_Medicamento (Descripcion) VALUES ('Antialérgico');


-------------------------------------------- Creación de la tabla Medicamento ----------------------------------------------------
CREATE TABLE Medicamento (
    ID_Medicamentos NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    Nombre_Medicamento VARCHAR2(45),
    No_Lote VARCHAR2(45),
    ID_Producto_TM NUMBER,
    ID_Tipo_Medicamento NUMBER,
    Img VARCHAR2(50),
    Precio NUMBER,
    Existencias NUMBER,
    Fecha_Vencimiento DATE,
    Fecha_Laboracion DATE,
    CONSTRAINT FK_ID_Producto_TM FOREIGN KEY (ID_Producto_TM) REFERENCES Productos_Detalle (ID_Producto),
    CONSTRAINT FK_ID_Tipo_Medicamento FOREIGN KEY (ID_Tipo_Medicamento) REFERENCES Tipo_Medicamento (ID_Tipo_Medicamento)
);


INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('FLVIDEFENAC 1.0G/100ML SOL. ANALGESICO', 'A12345', 1, 1, 'MA_1.jpg', 150, 100, TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('NODOR ICE GEL ANALGESICO 170G', 'A12345', 2, 1, 'MA_2.jpg', 200, 50, TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('ETORICOXIB FS 120 MG X 30 TABLETAS', 'AFR345', 3, 1, 'MA_3.jpg', 150, 75, TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('CLINDAMICINA FS 300MG CAJA X 30 CÁPSULAS', 'A17444', 1, 1, 'MANT_6.jpg', 250, 30, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('CIPROFLOXACINA FS 500 MG X 1 TABLETA', 'A1275I', 5, 2, 'MANT_5.jpg', 175.50, 100, TO_DATE('2023-04-25', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('CALMOL (ACETAMINOFEN) GOTAS X 30 ML', 'O94345', 4, 1, 'MA_4.jpg', 250, 200, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('CLINDAMICINA FS 300MG CAJA X 30 CÁPSULAS', 'A17444', 2, 1, 'MANT_6.jpg', 250.90, 50, TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('CEFUROXIMA FS 500 MG CAJA X 60 TAB', 'S4RG545', 1, 2, 'MANT_7.jpg', 275.95, 75, TO_DATE('2023-04-25', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('CEFIXIMA FS 400 MG X 6 TABLETAS', 'A12MOT', 1, 2, 'MANT_8.jpg', 175, 200, TO_DATE('2023-04-30', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('AMPISINT 500 MG (AMPICILINA)X1 CAPGV', 'A12780', 5, 2, 'MANT_9.jpg', 150, 30, TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES('MATROSULFA (TRIMETOPRIN SULFA)X 60MLGV', 'A15545', 4, 2, 'MANT_10.jpg', 150.75, 100, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('DICLOFENACO DE POTASIO FS 50MG X 100 TAB', 'A1LO45', 2, 3, 'MANTFLA_11.jpg', 200, 150, TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('ETORICOXIB FS 120 MG X 30 TABLETAS', 'TF6345', 1, 3, 'MANTFLA_12.jpg', 100.75, 750, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES('AMOXICILINA (AMOXIFAR) 500 MG X 1 CAPS', 'A14645', 2, 3, 'MANTFLA_13.jpg', 175.05, 500, TO_DATE('2023-04-30', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES('DECALAN TROCIZCOS SOBRE X 4', 'A12345', 2, 3, 'MANTFLA_14.jpg', 175, 50, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES('IBUPROFENO FS 600MG X 1 TABLETA GV', 'A12ER45', 4, 3, 'MANTFLA_15.jpg', 125, 75, TO_DATE('2023-09-30', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('HISTADRIL ALERGIAS JARABE X 120 ML', 'A12FN5', 5, 5, 'MANTALER_16.jpg', 250, 100, TO_DATE('2023-03-31', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('LORATADINA FS 10 MG CAJA X 10 TABLETAS', 'A12YU5', 5, 5, 'MANTALER_17.jpg', 255.75, 35, TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('DESLORATADINA FS 5 MG CAJA X10 TAB', 'AT12045', 5, 5, 'MANTALER_18.jpg', 175, 40, TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('DESLORATADINA FS JARABE FRASCO X 60 ML', 'A13N45', 5, 5, 'MANTALER_19.jpg', 100.50, 100, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO Medicamento (Nombre_Medicamento, No_Lote, ID_Producto_TM, ID_Tipo_Medicamento, Img, Precio, Existencias, Fecha_Laboracion, Fecha_Vencimiento)
VALUES ('ALERGIL JBE. 120ML', 'A12345', 5, 5, 'MANTALER_20.jpg', 100.50, 40, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'));




--------------------------------- Creación de la tabla Suplementos -------------------------------------------
CREATE TABLE Suplementos (
    ID_Suplementos NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45),
    ID_Producto NUMBER,
    ID_Tipo_Medicamento NUMBER,
    Img VARCHAR2(50),
    Precio NUMBER,
    Existencias NUMBER,
    Fecha_Vencimiento DATE,
    Fecha_Laboracion DATE,
    CONSTRAINT FK_ID_Productos_Suplementos FOREIGN KEY (ID_Producto) REFERENCES Productos_Detalle (ID_Producto),
    CONSTRAINT FK_ID_Tipo_Medicamento_DS FOREIGN KEY (ID_Tipo_Medicamento) REFERENCES Tipo_Medicamento (ID_Tipo_Medicamento)
);

SELECT * FROM Suplementos

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('21st Century Suplemento de calcio, 600 mg 400 unidades', 1, 3, 'S_1.jpg', TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 300);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('FERROMAX B,12 10ML AMPBEB X15', 2, 3, 'S_2.png', TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 200);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('suplemento-nutricional-l-vitamin-way D', 3, 3, 'S_3.webp', TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), 250);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('Kirkland Omega-3 Aceite de pescado 1000 mg 300 cápsulas', 4, 3, 'S_4.jpg', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), 180);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('multivitaminicop', 5, 3, 'S_5.png', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), 400);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('TERAMIN MULTI (VITAMINAS) CAJA X 30', 3, 3, 'S_6.jpg', TO_DATE('2023-04-25', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 150);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('ACFOL PRENATAL FCO X 30 TABS PROMO 1+1', 5, 3, 'S_7.jpg', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 250);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('FITAMIN CABELLO UÑAS Y PIEL X 60', 4, 3, 'S_8.jpg', TO_DATE('2023-04-25', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 300);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('SUKROL JBE MANZANA 240 ML', 2, 3, 'S_9.jpg', TO_DATE('2023-04-30', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'), 100);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('SUKROL NIÑOS CEREZA 120 ML', 5, 3, 'S_10.jpg', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 120);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('VITASYM VITAMINA E 400 UI X 60 CAPS', 5, 3, 'S_11.jpg', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 80);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('FITAMIN ACTIFIT PROTEINA VAINILLA 2LBS', 5, 3, 'S_12.jpg', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), 200);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('FITAMIN MELATONINA+MAGNESIO 240 ML', 3, 3, 'S_13.jpg', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 150);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('ALBENDAFAR CAJA X 2 TAB', 1, 3, 'S_14.jpg', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), 50);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('TERAMIN ZINC 50 MG CAJA X 50 TABLETAS', 1, 3, 'S_15.jpg', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), 100);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('102 Plus, Suplemento Dietario 102 Plus Vitaminas y Minerales x 60 comprimidos', 3, 3, 'S_16.jpg', TO_DATE('2023-09-30', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 180);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('LASANTE VIT C MANDA 500MG SOB X12', 5, 3, 'S_18.jpg', TO_DATE('2023-03-31', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), 120);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('HADASSA VITAMINA C 30ML(ND)', 4, 3, 'S_18.jpg', TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 90);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('BABARIA VITAMINA C SERUM 30ML', 3, 3, 'S_19.jpg', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), 70);

INSERT INTO Suplementos (Descripcion, ID_Producto, ID_Tipo_Medicamento, Img, Fecha_Laboracion, Fecha_Vencimiento, Existencias)
VALUES ('LACABINE AMPOLLAS VITAMINA C CAJAX10 2ML', 2, 3, 'S_20.jpg', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 150);







---------------------- Creación de la tabla Restricciones ----------------------
CREATE TABLE Restricciones (
    ID_Restricciones NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

------------------------ Inserción de valores en la tabla Restricciones ----------------------------
INSERT INTO Restricciones (Descripcion) VALUES ('Alergia a la lactosa');
INSERT INTO Restricciones (Descripcion) VALUES ('Hipertensión');
INSERT INTO Restricciones (Descripcion) VALUES ('Diabetes');
INSERT INTO Restricciones (Descripcion) VALUES ('Alergia al gluten');
INSERT INTO Restricciones (Descripcion) VALUES ('Intolerancia a la cafeína');


------------------------------------ Creación de la tabla Restriccion_Productos -----------------------------------------
CREATE TABLE Restriccion_Productos (
    ID_Restricciones_Productos NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Restricciones NUMBER NOT NULL,
    ID_Producto NUMBER NOT NULL,
    CONSTRAINT FK_ID_Productos_RP FOREIGN KEY (ID_Producto) REFERENCES Productos_Detalle (ID_Producto),
    CONSTRAINT FK_ID_Restricciones_RP FOREIGN KEY (ID_Restricciones) REFERENCES Restricciones (ID_Restricciones)
);

----------------------------- Inserción de valores en la tabla Restriccion_Productos -----------------------------
INSERT INTO Restriccion_Productos (ID_Restricciones, ID_Producto) VALUES (1, 1);
INSERT INTO Restriccion_Productos (ID_Restricciones, ID_Producto) VALUES (2, 2);
INSERT INTO Restriccion_Productos (ID_Restricciones, ID_Producto) VALUES (3, 3);
INSERT INTO Restriccion_Productos (ID_Restricciones, ID_Producto) VALUES (4, 4);
INSERT INTO Restriccion_Productos (ID_Restricciones, ID_Producto) VALUES (5, 5);


---------------- Creación de la tabla Forma_Administracion ----------------
CREATE TABLE Forma_Administracion (
    ID_Forma_Administracion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL,
    Formas_Administracion VARCHAR2(45) NOT NULL
);

------------------------------------------- Inserción de valores en la tabla Forma_Administracion ----------------------------------------
INSERT INTO Forma_Administracion (Descripcion, Formas_Administracion) VALUES ('Tableta', 'Oral');
INSERT INTO Forma_Administracion (Descripcion, Formas_Administracion) VALUES ('Cápsula', 'Oral');
INSERT INTO Forma_Administracion (Descripcion, Formas_Administracion) VALUES ('Jarabe', 'Oral');
INSERT INTO Forma_Administracion (Descripcion, Formas_Administracion) VALUES ('Inyección', 'Intramuscular');
INSERT INTO Forma_Administracion (Descripcion, Formas_Administracion) VALUES ('Parche', 'Transdérmico');


---------------------------------------------- Creación de la tabla Formas_Adm_Productos ------------------------------------------------------
CREATE TABLE Formas_Adm_Productos (
    ID_Formas_AdmProductos NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Producto NUMBER NOT NULL,
    ID_Forma_Administracion NUMBER NOT NULL,
    CONSTRAINT FK_ID_Producto_F_ADM_P FOREIGN KEY (ID_Producto) REFERENCES Productos_Detalle (ID_Producto),
    CONSTRAINT FK_ID_Forma_Administracion FOREIGN KEY (ID_Forma_Administracion) REFERENCES Forma_Administracion (ID_Forma_Administracion)
);

-------------------------------- Inserción de valores en la tabla Formas_Adm_Productos -----------------------------------
INSERT INTO Formas_Adm_Productos (ID_Producto, ID_Forma_Administracion) VALUES (1, 1);
INSERT INTO Formas_Adm_Productos (ID_Producto, ID_Forma_Administracion) VALUES (2, 2);
INSERT INTO Formas_Adm_Productos (ID_Producto, ID_Forma_Administracion) VALUES (3, 3);
INSERT INTO Formas_Adm_Productos (ID_Producto, ID_Forma_Administracion) VALUES (4, 4);
INSERT INTO Formas_Adm_Productos (ID_Producto, ID_Forma_Administracion) VALUES (5, 5);


---------------------------- Creación de la tabla Factura_Producto ----------------------------------



--------------- Creación de la tabla Formas_Pagos ----------------------
CREATE TABLE Formas_Pagos (
    ID_Formas_Pago NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Descripcion VARCHAR2(45) NOT NULL
);

------------------------ Inserción de valores en la tabla Formas_Pagos ---------------------------
INSERT INTO Formas_Pagos (Descripcion) VALUES ('Efectivo');
INSERT INTO Formas_Pagos (Descripcion) VALUES ('Tarjeta de Crédito');
INSERT INTO Formas_Pagos (Descripcion) VALUES ('Tarjeta de Débito');
INSERT INTO Formas_Pagos (Descripcion) VALUES ('Transferencia Bancaria');
INSERT INTO Formas_Pagos (Descripcion) VALUES ('Cheque');


------------------------------- Creación de la tabla Factura_FormaPagos -------------------------------------
CREATE TABLE Factura_FormaPagos (
    ID_Factura_FormaPago NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Factura NUMBER NOT NULL,
    ID_Formas_Pago NUMBER NOT NULL,
    CONSTRAINT FK_ID_Factura_FF FOREIGN KEY (ID_Factura) REFERENCES Factura (ID_Factura),
    CONSTRAINT FK_ID_Formas_Pago_FF FOREIGN KEY (ID_Formas_Pago) REFERENCES Formas_Pagos (ID_Formas_Pago)
);

------------------------- Inserción de valores en la tabla Factura_FormaPagos ----------------------------
INSERT INTO Factura_FormaPagos (ID_Factura, ID_Formas_Pago) VALUES (1, 1);
INSERT INTO Factura_FormaPagos (ID_Factura, ID_Formas_Pago) VALUES (2, 2);
INSERT INTO Factura_FormaPagos (ID_Factura, ID_Formas_Pago) VALUES (3, 3);
INSERT INTO Factura_FormaPagos (ID_Factura, ID_Formas_Pago) VALUES (4, 4);
INSERT INTO Factura_FormaPagos (ID_Factura, ID_Formas_Pago) VALUES (5, 5);


LTER SESSION  SET "_ORACLE_SCRIPT" = TRUE; 

CREATE USER ADMIN IDENTIFIED BY 123

DEFAULT TABLESPACE users

TEMPORARY TABLESPACE temp

QUOTA UNLIMITED ON users;

CREATE ROLE ADMINISTRADORES;

GRANT CREATE SESSION, CREATE ANY TABLE, CREATE ANY PROCEDURE, ALTER ANY TABLE, ALTER ANY PROCEDURE, DROP ANY TABLE, DROP ANY PROCEDURE TO ADMINISTRADORES;

GRANT ADMINISTRADORES TO ADMIN;

---CONSULTA PARA VERIFICARLOS ROLES CREADOS

SELECT * FROM DBA_ROLES:

---CONSULTA PARA VARIFICAR LOS PRIVILEGIOS ASIGNADOS A UN ROL

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE='ADMINISTRADORES';

SELECT * FROM Suplementos






