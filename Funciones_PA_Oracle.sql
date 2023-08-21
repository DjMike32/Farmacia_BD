
-------- PA 1 --------

CREATE OR REPLACE PROCEDURE MedicamentosPorFormaAdmin 
(
    p_Forma_Administracion VARCHAR2
)
IS
BEGIN
    FOR r IN (
        SELECT P.Nombre_Producto, FA.Formas_Administracion
        FROM Productos P
        JOIN Formas_Adm_Productos FAP ON P.ID_Producto = FAP.ID_Producto
        JOIN Forma_Administracion FA ON FAP.ID_Forma_Administracion = FA.ID_Forma_Administracion
        WHERE FA.Formas_Administracion = p_Forma_Administracion
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Medicamento: ' || r.Nombre_Producto || ', Forma de Administración: ' || r.Formas_Administracion);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de medicamentos con forma de administración ' || p_Forma_Administracion || ': ' || SQL%ROWCOUNT);
/*EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);*/
END MedicamentosPorFormaAdmin;
/

SET SERVEROUTPUT ON;
EXEC MedicamentosPorFormaAdmin('Oral');


--------- PA 2 ------------

CREATE OR REPLACE PROCEDURE MedicamentosPorFormaAdmin (p_Forma_Administracion VARCHAR2)
IS
    v_Total NUMBER := 0; -- Variable para almacenar el total de medicamentos
BEGIN
    FOR r IN (
        SELECT P.Nombre_Producto, FA.Formas_Administracion
        FROM Productos P
        JOIN Formas_Adm_Productos FAP ON P.ID_Producto = FAP.ID_Producto
        JOIN Forma_Administracion FA ON FAP.ID_Forma_Administracion = FA.ID_Forma_Administracion
        WHERE FA.Formas_Administracion = p_Forma_Administracion
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Medicamento: ' || r.Nombre_Producto || ', Forma de Administración: ' || r.Formas_Administracion);
        v_Total := v_Total + 1; -- Incrementar el total por cada medicamento
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de medicamentos con forma de administración ' || p_Forma_Administracion || ': ' || v_Total);

END MedicamentosPorFormaAdmin;
/


-------  PA 3 -----------


CREATE OR REPLACE PROCEDURE MedicamentosPorFecha (p_Fecha DATE) IS
BEGIN
    FOR r IN (
        SELECT P.Nombre_Producto, P.Fecha_Laboracion
        FROM Productos P
        WHERE P.Fecha_Laboracion = p_Fecha
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Medicamento: ' || r.Nombre_Producto || ', Fecha de Laboración: ' || TO_CHAR(r.Fecha_Laboracion, 'YYYY-MM-DD'));
    END LOOP;
END MedicamentosPorFecha;
/
SET SERVEROUTPUT ON;
EXEC MedicamentosPorFecha(TO_DATE('2023-07-15', 'YYYY-MM-DD')); -- Reemplaza la fecha con la que desees



--------- PA 4 ---------



CREATE OR REPLACE PROCEDURE ConsultarFormaPagoFacturas(p_Forma_Pago IN VARCHAR2)
IS
    v_Descripcion Formas_Pagos.Descripcion%TYPE;
BEGIN
    -- Buscar la descripción de la forma de pago proporcionada
    SELECT Descripcion INTO v_Descripcion
    FROM Formas_Pagos
    WHERE Descripcion = p_Forma_Pago;

    -- Imprimir las facturas que usan la forma de pago proporcionada
    FOR rec IN (SELECT F.ID_Factura, FP.Descripcion
                FROM Factura F
                INNER JOIN Factura_FormaPagos FFP ON F.ID_Factura = FFP.ID_Factura
                INNER JOIN Formas_Pagos FP ON FFP.ID_Formas_Pago = FP.ID_Formas_Pago
                WHERE FP.Descripcion = v_Descripcion) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Factura ID: ' || rec.ID_Factura || ', Forma de Pago: ' || rec.Descripcion);
    END LOOP;

    -- Contar el número total de facturas con la forma de pago proporcionada
    DECLARE
        v_Total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_Total
        FROM Factura F
        JOIN Factura_FormaPagos FFP ON f.ID_Factura = FFP.ID_Factura
        JOIN Formas_Pagos FP ON ffp.ID_Formas_Pago = FP.ID_Formas_Pago
        WHERE FP.Descripcion = v_Descripcion;

        DBMS_OUTPUT.PUT_LINE('Total de Facturas con Forma de Pago "' || v_Descripcion || '": ' || v_Total);
    END;
END;
/

SET SERVEROUTPUT ON;
EXEC ConsultarFormaPagoFacturas('Cheque');



-------- PA 5 ----------


CREATE OR REPLACE PROCEDURE CalcularVentasTotales(
    p_NombreMedicamento IN VARCHAR2,
    p_TotalVentas OUT NUMBER
) 
IS
BEGIN
    SELECT SUM(F.TOTAL) INTO p_TotalVentas
    FROM FACTURA F
    JOIN FACTURA_PRODUCTO FP ON F.ID_FACTURA = FP.ID_FACTURA
    JOIN PRODUCTOS P ON FP.ID_PRODUCTO = P.ID_PRODUCTO
    WHERE P.NOMBRE_PRODUCTO = p_NombreMedicamento;
END;
/

VARIABLE v_TotalVentas NUMBER;
EXEC CalcularVentasTotales('Ibuprofeno', :v_TotalVentas);
PRINT v_TotalVentas;


INSERT INTO Factura (ID_Factura, Fecha_Emision, Impuesto, Descuento, CAI, Total, Descripcion)
VALUES (6, TO_DATE('2023-08-17', 'YYYY-MM-DD'), 20, 8, 'KLMNO12346', 220.75, 'Compra de medicamentos');

INSERT INTO Factura_Producto (ID_Factura_Productos, ID_Factura, ID_Producto) 
VALUES (6, 6, 3);



------ PA 6 ------


CREATE OR REPLACE PROCEDURE BuscarMedicamentos(
    p_Descripcion IN VARCHAR2
) 
IS
BEGIN
    FOR REC IN (SELECT NOMBRE_PRODUCTO FROM PRODUCTOS WHERE DESCRIPCION LIKE '%' || p_Descripcion || '%') LOOP
        DBMS_OUTPUT.PUT_LINE('Medicamento encontrado: ' || REC.NOMBRE_PRODUCTO);
    END LOOP;
END;
/

EXEC BuscarMedicamentos('Antiinflamatorio');



------- FUNCION 1 -------


CREATE OR REPLACE FUNCTION GetDescripcionBeneficio(p_idTipoCliente NUMBER) RETURN VARCHAR2 IS
    v_descripcion VARCHAR2(100);
BEGIN
    SELECT b.Descripcion INTO v_descripcion
    FROM Beneficios_TipoCliente btc
    JOIN Beneficios b ON btc.ID_Beneficio = b.ID_Beneficio
    WHERE btc.ID_Tipo_Cliente = p_idTipoCliente;
    
    RETURN v_descripcion;
END;
/
SELECT GetDescripcionBeneficio(1) FROM DUAL; 




--------  FUNCION 2 --------

CREATE OR REPLACE FUNCTION CountClientesRegistradosEnFecha(p_fecha DATE) RETURN NUMBER IS
    v_cantidad NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cantidad
    FROM Clientes
    WHERE Fecha_Ingreso = p_fecha;
    
    RETURN v_cantidad;
END;
/

SELECT CountClientesRegistradosEnFecha(TO_DATE('2023-01-15', 'YYYY-MM-DD')) FROM DUAL;



------- FUNCION 3 --------

CREATE OR REPLACE FUNCTION GetNombreCompletoPersona(p_idPersona NUMBER) RETURN VARCHAR2 IS
    v_nombreCompleto VARCHAR2(100);
BEGIN
    SELECT P_Nombre || ' ' || S_Nombre || ' ' || P_Apellido || ' ' || S_Apellido
    INTO v_nombreCompleto
    FROM Persona
    WHERE ID_Persona = p_idPersona;
    
    RETURN v_nombreCompleto;
END;
/

SELECT GetNombreCompletoPersona(1) FROM DUAL;



------- FUNCION 4 -------

CREATE OR REPLACE FUNCTION GetDireccionDrogueria(p_idDrogueria NUMBER) 
RETURN VARCHAR2 
IS
    v_direccion VARCHAR2(200);
BEGIN
    SELECT dir.Descripcion
    INTO v_direccion
    FROM Droguerias d
    INNER JOIN Direccion dir ON d.ID_Direccion = dir.ID_Direccion
    WHERE d.ID_Drogueria = p_idDrogueria;
    
    RETURN v_direccion;
END;
/


SELECT GetDireccionDrogueria(1) FROM DUAL;



-------- FUNCION 5 -------

CREATE OR REPLACE FUNCTION GetTipoClientePersona(p_idPersona NUMBER) RETURN VARCHAR2 IS
    v_tipoCliente VARCHAR2(45);
BEGIN
    SELECT tc.Descripcion
    INTO v_tipoCliente
    FROM Tipo_Clientes tc
    JOIN Clientes c ON tc.ID_Tipo_Cliente = c.ID_Tipo_Cliente
    WHERE c.ID_Persona = p_idPersona;
    
    RETURN v_tipoCliente;
END;
/

SELECT GetTipoClientePersona(1) FROM DUAL;





