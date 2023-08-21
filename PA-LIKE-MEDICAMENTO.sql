-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<MG>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE PA_BuscarMedicamentoPorNombre
    @p_nombre_patron NVARCHAR(100)
AS
BEGIN
    DECLARE @id_medicamentos INT,
            @nombre_medicamento NVARCHAR(100),
            @no_lote NVARCHAR(50),
            @id_producto_tm INT,
            @id_tipo_medicamento INT,
            @img NVARCHAR(100),
            @precio DECIMAL(18, 2),
            @existencias INT,
            @fecha_vencimiento DATE,
            @fecha_laboracion DATE,
            @descripcion NVARCHAR(100);

    DECLARE @counter INT = 1;

    WHILE @counter <= (SELECT COUNT(*) FROM Medicamento WHERE Nombre_Medicamento LIKE '%' + @p_nombre_patron + '%')
    BEGIN
        SELECT TOP 1
            @id_medicamentos = m.id_medicamentos,
            @nombre_medicamento = m.nombre_medicamento,
            @no_lote = m.no_lote,
            @id_producto_tm = m.id_producto_tm,
            @id_tipo_medicamento = m.id_tipo_medicamento,
            @img = m.img,
            @precio = m.precio,
            @existencias = m.existencias,
            @fecha_vencimiento = m.fecha_vencimiento,
            @fecha_laboracion = m.fecha_laboracion,
            @descripcion = tm.Descripcion
        FROM Medicamento m
        INNER JOIN Tipo_Medicamentos tm ON m.id_tipo_medicamento = tm.id_tipo_medicamento
        WHERE m.Nombre_Medicamento LIKE '%' + @p_nombre_patron + '%'
        ORDER BY m.id_medicamentos;

        PRINT 'ID Medicamento: ' + CAST(@id_medicamentos AS NVARCHAR(20));
        PRINT 'Nombre Medicamento: ' + @nombre_medicamento;
        PRINT 'Número de Lote: ' + @no_lote;
        PRINT 'ID Producto: ' + CAST(@id_producto_tm AS NVARCHAR(20));
        PRINT 'ID Tipo Medicamento: ' + CAST(@id_tipo_medicamento AS NVARCHAR(20));
        PRINT 'Imagen: ' + @img;
        PRINT 'Precio: ' + CAST(@precio AS NVARCHAR(20));
        PRINT 'Existencias: ' + CAST(@existencias AS NVARCHAR(20));
        PRINT 'Fecha de Vencimiento: ' + CONVERT(NVARCHAR(20), @fecha_vencimiento, 121);
        PRINT 'Fecha de Laboración: ' + CONVERT(NVARCHAR(20), @fecha_laboracion, 121);
        PRINT 'Tipo Medicamento: ' + @descripcion;
        PRINT '--------------------------------';

        SET @counter = @counter + 1;
    END;
END;

-- Prueba ---
EXEC PA_BuscarMedicamentoPorNombre @p_nombre_patron = N'ALERGIL JBE. 120ML';