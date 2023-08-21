SELECT * FROM MEDICAMENTO



------------------PROCEDIMIENTO ALMACENADO--------------------
CREATE OR REPLACE PROCEDURE ObtenerMedicamentoPorID(
    p_id_medicamento IN NUMBER,
    p_nombre OUT VARCHAR2,
    p_no_lote OUT VARCHAR2,
    p_nombre_tipo_medicamento OUT VARCHAR2
) IS
BEGIN
    SELECT M.Nombre_Medicamento, M.No_lote,
           TM.Descripcion
    INTO p_nombre, p_no_lote,
         p_nombre_tipo_medicamento
    FROM Medicamento M
    INNER JOIN Tipo_Medicamento TM ON m.id_tipo_medicamento = tm.id_tipo_medicamento
    WHERE M.id_medicamentos = p_id_medicamento;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nombre := NULL;
        p_no_lote := NULL;
        p_nombre_tipo_medicamento := NULL;
END ObtenerMedicamentoPorID;
/



SET SERVEROUTPUT ON;

DECLARE
    v_id_medicamento NUMBER := 26; -- Cambia esto al ID que desees buscar
    v_nombre VARCHAR2(100);
    v_no_lote VARCHAR2(50);
    v_nombre_tipo_medicamento VARCHAR2(100);
BEGIN
    ObtenerMedicamentoPorID(
        p_id_medicamento => v_id_medicamento,
        p_nombre => v_nombre,
        p_no_lote => v_no_lote,
        p_nombre_tipo_medicamento => v_nombre_tipo_medicamento
    );

    IF v_nombre IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
        DBMS_OUTPUT.PUT_LINE('Número de Lote: ' || v_no_lote);
        DBMS_OUTPUT.PUT_LINE('Nombre del Tipo de Medicamento: ' || v_nombre_tipo_medicamento);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Medicamento no encontrado.');
    END IF;
END;
/





--------------------PA_BUSCAR MEDICAMENTO POR EL NOMBRE-------------------------
CREATE OR REPLACE PROCEDURE BuscarMedicamentoPorNombre(
    p_nombre_patron IN VARCHAR2
) IS
BEGIN
    FOR med_info IN (
        SELECT M.Nombre_Medicamento, M.No_Lote,
               TM.Descripcion
        FROM Medicamento M
        INNER JOIN Tipo_Medicamento TM ON M.id_tipo_medicamento = TM.id_tipo_medicamento
        WHERE M.Nombre_Medicamento LIKE '%' || p_nombre_patron || '%'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre Medicamento: ' || med_info.Nombre_Medicamento);
        DBMS_OUTPUT.PUT_LINE('Número de Lote: ' || med_info.No_Lote);
        DBMS_OUTPUT.PUT_LINE('Nombre Tipo Medicamento: ' || med_info.Descripcion);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
    END LOOP;
END BuscarMedicamentoPorNombre;
/

-----------------PRUEBA DE PROCEDIMIENTO ALMACENADO-------------------
SET SERVEROUTPUT ON;

DECLARE
    v_nombre_patron VARCHAR2(100) := 'ALERGIL JBE. 120ML'; -- Cambia esto al patrón que desees buscar
BEGIN
    BuscarMedicamentoPorNombre(p_nombre_patron => v_nombre_patron);
END;
/


------------------------CON LOS DEMÁS DATOS-----------
CREATE OR REPLACE PROCEDURE PA_BuscarMedicamentoPorNombre(
    p_nombre_patron IN VARCHAR2
) IS
BEGIN
    FOR med_info IN (
        SELECT m.id_medicamentos, m.nombre_medicamento, m.no_lote,
               m.id_producto_tm, m.id_tipo_medicamento, m.img, m.precio, m.existencias,
               m.fecha_vencimiento, m.fecha_laboracion,
               tm.Descripcion
        FROM Medicamento m
        INNER JOIN Tipo_Medicamento tm ON m.id_tipo_medicamento = tm.id_tipo_medicamento
        WHERE m.Nombre_Medicamento LIKE '%' || p_nombre_patron || '%'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Medicamento: ' || med_info.id_medicamentos);
        DBMS_OUTPUT.PUT_LINE('Nombre Medicamento: ' || med_info.nombre_medicamento);
        DBMS_OUTPUT.PUT_LINE('Número de Lote: ' || med_info.no_lote);
        DBMS_OUTPUT.PUT_LINE('ID Producto: ' || med_info.id_producto_tm);
        DBMS_OUTPUT.PUT_LINE('ID Tipo Medicamento: ' || med_info.id_tipo_medicamento);
        DBMS_OUTPUT.PUT_LINE('Imagen: ' || med_info.img);
        DBMS_OUTPUT.PUT_LINE('Precio: ' || med_info.precio);
        DBMS_OUTPUT.PUT_LINE('Existencias: ' || med_info.existencias);
        DBMS_OUTPUT.PUT_LINE('Fecha de Vencimiento: ' || med_info.fecha_vencimiento);
        DBMS_OUTPUT.PUT_LINE('Fecha de Laboración: ' || med_info.fecha_laboracion);
        DBMS_OUTPUT.PUT_LINE('Tipo Medicamento: ' || med_info.descripcion);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
    END LOOP;
END PA_BuscarMedicamentoPorNombre;
/

SET SERVEROUTPUT ON;

DECLARE
    v_nombre_patron VARCHAR2(100) := 'CAJA'; -- Cambia esto al patrón que desees buscar
BEGIN
    PA_BuscarMedicamentoPorNombre(p_nombre_patron => v_nombre_patron);
END;



----------------------------------FUNCION-------------------------------------
CREATE OR REPLACE FUNCTION FN_DescripcionBeneficio(p_idTipoCliente NUMBER) 
RETURN VARCHAR2 
IS
    v_descripcion VARCHAR2(100);
BEGIN
    SELECT
        CASE
            WHEN p_idTipoCliente = 1 THEN (
                SELECT Descripcion
                FROM Beneficios
                WHERE ID_Beneficio = 3
            )
            WHEN p_idTipoCliente = 2 THEN (
                SELECT Descripcion
                FROM Beneficios
                WHERE ID_Beneficio = 2
            )
            WHEN p_idTipoCliente = 3 THEN (
                SELECT Descripcion
                FROM Beneficios
                WHERE ID_Beneficio = 4
            )
            WHEN p_idTipoCliente = 4 THEN (
                SELECT Descripcion
                FROM Beneficios
                WHERE ID_Beneficio = 5
            )
            WHEN p_idTipoCliente = 5 THEN (
                SELECT Descripcion
                FROM Beneficios
                WHERE ID_Beneficio = 1
            )
            ELSE 'NO HAY BENEFICIO'
        END
    INTO v_descripcion
    FROM DUAL;
    
    RETURN v_descripcion;
END;
/

--------------------PRUEBA DE FUNCIÓN---------------------
SELECT FN_DescripcionBeneficio(3) AS Descripcion FROM DUAL;


CREATE OR REPLACE FUNCTION myfunc RETURN VARCHAR2 AS
BEGIN
    RETURN 'Hello';
END;



CREATE FUNCTION FN_DescripcionBeneficio(@p_idTipoCliente INT) 
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @v_descripcion VARCHAR(100);
    
    SELECT
        @v_descripcion = 
            CASE
                WHEN @p_idTipoCliente = 1 THEN (
                    SELECT Descripcion
                    FROM Beneficios
                    WHERE ID_Beneficio = 3
                )
                WHEN @p_idTipoCliente = 2 THEN (
                    SELECT Descripcion
                    FROM Beneficios
                    WHERE ID_Beneficio = 2
                )
                WHEN @p_idTipoCliente = 3 THEN (
                    SELECT Descripcion
                    FROM Beneficios
                    WHERE ID_Beneficio = 4
                )
                WHEN @p_idTipoCliente = 4 THEN (
                    SELECT Descripcion
                    FROM Beneficios
                    WHERE ID_Beneficio = 5
                )
                WHEN @p_idTipoCliente = 5 THEN (
                    SELECT Descripcion
                    FROM Beneficios
                    WHERE ID_Beneficio = 1
                )
                ELSE 'NO HAY BENEFICIO'
            END;

    RETURN @v_descripcion;
END;





