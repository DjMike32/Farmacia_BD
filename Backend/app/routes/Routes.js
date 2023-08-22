


const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');

const dbConfig = {
  user: 'Michael',
  password: 'admin',
  connectString: 'localhost:1521/xe'
};

// Definir tus rutas aquí utilizando el objeto "router"



router.post('/insertar-Pais', async (req, res) => {
  try {
    const { descripcion } = req.body;
    
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    
    console.log('Conexión a Oracle exitosa');
    
    // Realizar la inserción en la tabla Pais
    await connection.execute(
      'INSERT INTO Pais (Descripcion) VALUES (:descripcion)',
      [descripcion]
    );
    
    // Confirmar manualmente la transacción
    await connection.execute('COMMIT');
    
    connection.close();

    res.json({ success: true, message: 'Inserción exitosa' });
  } catch (error) {
    console.error('Error al realizar la inserción:', error);
    res.status(500).json({ error: 'Error al realizar la inserción' });
  }
});


router.delete('/eliminar-Pais/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    
    console.log('Conexión a Oracle exitosa');
    
    // Realizar la eliminación en la tabla Pais
    await connection.execute(
      'DELETE FROM Pais WHERE ID_Pais = :id',
      [id]
    );
    
    // Confirmar manualmente la transacción
    await connection.execute('COMMIT');
    
    connection.close();

    res.json({ success: true, message: 'Eliminación exitosa' });
  } catch (error) {
    console.error('Error al realizar la eliminación:', error);
    res.status(500).json({ error: 'Error al realizar la eliminación' });
  }
});





router.delete('/eliminar-Empleado/:id', async (req, res) => {
  try {
    const empleadoId = req.params.id;

    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');

    // Realizar la eliminación en la tabla Empleados
    const result = await connection.execute(
      'DELETE FROM Empleados WHERE ID_Empleado = :id',
      [empleadoId]
    );

    // Realizar el commit explícito
    await connection.commit();

    connection.close();

    console.log('Eliminación realizada correctamente');
    res.json({ success: true, message: 'Eliminación exitosa' });
  } catch (error) {
    console.error('Error al realizar la eliminación:', error);
    res.status(500).json({ error: 'Error al realizar la eliminación' });
  }
});


router.put('/actualizar-Pais/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { descripcion } = req.body;
    
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    
    console.log('Conexión a Oracle exitosa');
    
    // Realizar la actualización en la tabla Pais
    await connection.execute(
      'UPDATE Pais SET Descripcion = :descripcion WHERE ID_Pais = :id',
      [descripcion, id]
    );
    
    // Confirmar manualmente la transacción
    await connection.execute('COMMIT');
    
    connection.close();

    res.json({ success: true, message: 'Actualización exitosa' });
  } catch (error) {
    console.error('Error al realizar la actualización:', error);
    res.status(500).json({ error: 'Error al realizar la actualización' });
  }
});


router.get('/medicamentos', async (req, res) => {
  try {
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Conexión a Oracle exitosa');

    // Realizar consulta para obtener todos los valores de la tabla Medicamento
    const result = await connection.execute(
      'SELECT * FROM Medicamento'
    );

    connection.close();
    const medicamentos = result.rows;
    console.log('Resultados de la consulta:', medicamentos);
    // Devolver los resultados en formato JSON
    res.json(result.rows);
  } catch (error) {
    console.error('Error al consultar los medicamentos:', error);
    res.status(500).json({ error: 'Error al consultar los medicamentos' });
  }
});


router.get('/buscar-medicamento/:nombre', async (req, res) => {
  try {
    const { nombre } = req.params;

    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Conexión a Oracle exitosa');

    // Ejecutar el bloque PL/SQL con el nombre proporcionado
    const plsqlBlock = `
    SET SERVEROUTPUT ON;
      DECLARE
        v_nombre_patron VARCHAR2(100) := :nombre;
      BEGIN
        PA_BuscarMedicamentoPorNombre(p_nombre_patron => v_nombre_patron);
      END;
    `;

    await connection.execute(plsqlBlock, [nombre]);

    connection.close();

    res.json({ success: true, message: 'Búsqueda exitosa' });
  } catch (error) {
    console.error('Error al buscar medicamento por nombre:', error);
    res.status(500).json({ error: 'Error al buscar medicamento por nombre' });
  }
});




router.get('/llamar-funcion', async (req, res) => {
  try {
    const connection = await oracledb.getConnection();
    let result;

    const bindVars = {
      ret: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 40 }
    };

    result = await connection.execute(
      `BEGIN
        :ret := FN_DescripcionBeneficio(:parametro);
      END;`,
      {
        ...bindVars,
        parametro: 3 // Aquí proporcionas el valor del parámetro
      }
    );

    connection.close();

    const returnValue = result.outBinds.ret;
    console.log(returnValue); // Mostrar el valor de retorno en la consola

    res.json({ success: true, returnValue });
  } catch (error) {
    console.error('Error al llamar a la función:', error);
    res.status(500).json({ success: false, error: 'Error al llamar a la función' });
  }
});


router.get('/llamar-pa', async (req, res) => {
  try {
    const connection = await oracledb.getConnection();

    // Definir el código PL/SQL del procedimiento almacenado
    const plsqlCode = `
      BEGIN
        PA_BuscarMedicamentoPorNombre(:p_nombre_patron);
      END;
    `;

    const bindVars = {
      p_nombre_patron: 'CAJA', // Cambia esto al patrón que desees buscar
    };

    // Ejecutar el procedimiento almacenado
    await connection.execute(plsqlCode, bindVars);

    connection.close();

    res.json({ success: true, message: 'Procedimiento ejecutado exitosamente' });
  } catch (error) {
    console.error('Error al ejecutar el procedimiento:', error);
    res.status(500).json({ success: false, error: 'Error al ejecutar el procedimiento' });
  }
});



router.get('/llamar-pa2', async (req, res) => {
  try {
    const connection = await oracledb.getConnection();

    // Habilitar el buffer de salida DBMS_OUTPUT para la conexión actual
    await connection.execute('BEGIN DBMS_OUTPUT.ENABLE(NULL); END;');

    // Definir el código PL/SQL del procedimiento almacenado
    const plsqlCode = `
      BEGIN
        PA_BuscarMedicamentoPorNombre(:p_nombre_patron);
      END;
    `;

    const bindVars = {
      p_nombre_patron: 'CAJA', // Cambia esto al patrón que desees buscar
    };

    // Ejecutar el procedimiento almacenado
    await connection.execute(plsqlCode, bindVars);

    // Recuperar y guardar los resultados del buffer DBMS_OUTPUT en un arreglo
    const outputLines = [];
    let outputLine = '';
    do {
      const result = await connection.execute('BEGIN DBMS_OUTPUT.GET_LINE(:line, :status); END;',
        { line: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 32767 },
          status: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        }
      );

      outputLine = result.outBinds.line;
      if (outputLine) {
        outputLines.push(outputLine);
        console.log(outputLine);
      }
    } while (outputLine);

    connection.close();

    res.json({ success: true, message: 'Procedimiento ejecutado exitosamente', output: outputLines });
  } catch (error) {
    console.error('Error al ejecutar el procedimiento:', error);
    res.status(500).json({ success: false, error: 'Error al ejecutar el procedimiento' });
  }
});

router.get('/llamar-pa3/:nombre_patron', async (req, res) => {
  try {
    const { nombre_patron } = req.params; // Obtener el valor del parámetro desde la URL
    const connection = await oracledb.getConnection();

    // Habilitar el buffer de salida DBMS_OUTPUT para la conexión actual
    await connection.execute('BEGIN DBMS_OUTPUT.ENABLE(NULL); END;');

    // Definir el código PL/SQL del procedimiento almacenado
    const plsqlCode = `
      BEGIN
        PA_BuscarMedicamentoPorNombre(:p_nombre_patron);
      END;
    `;

    const bindVars = {
      p_nombre_patron: nombre_patron, // Utilizar el valor del parámetro en el bindVars
    };

    // Ejecutar el procedimiento almacenado
    await connection.execute(plsqlCode, bindVars);

    // Recuperar y guardar los resultados del buffer DBMS_OUTPUT en un arreglo
    const outputLines = [];
    let outputLine = '';
    do {
      const result = await connection.execute('BEGIN DBMS_OUTPUT.GET_LINE(:line, :status); END;',
        { line: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 32767 },
          status: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        }
      );

      outputLine = result.outBinds.line;
      if (outputLine) {
        outputLines.push(outputLine);
        console.log(outputLine);
      }
    } while (outputLine);

    connection.close();

    res.json({ success: true, message: 'Procedimiento ejecutado exitosamente', output: outputLines });
  } catch (error) {
    console.error('Error al ejecutar el procedimiento:', error);
    res.status(500).json({ success: false, error: 'Error al ejecutar el procedimiento' });
  }
});


router.get('/obtener-todos-medicamentos', async (req, res) => {
  try {
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Conexión a Oracle exitosa');

    // Crear un bind variable para el cursor de salida
    const bindVars = {
      cursor: { type: oracledb.CURSOR, dir: oracledb.BIND_OUT }
    };

    const result = await connection.execute('BEGIN PA_ObtenerTodosLosMedicamentos(:cursor); END;', bindVars);

    const cursor = result.outBinds.cursor;
    const resultSet = await cursor.getRows(100); // Puedes ajustar el número de filas

    cursor.close();
    connection.close();

    res.json({ success: true, message: 'Medicamentos obtenidos exitosamente', data: resultSet });
  } catch (error) {
    console.error('Error al obtener todos los medicamentos:', error);
    res.status(500).json({ error: 'Error al obtener todos los medicamentos' });
  }
});



router.delete('/eliminar-medicamento/:id', async (req, res) => {
  const idMedicamento = req.params.id;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    const plsqlBlock = `
      BEGIN
        PA_EliminarMedicamento(p_id_medicamento => :idMedicamento);
      END;
    `;

    await connection.execute(plsqlBlock, { idMedicamento });
    connection.close();

    res.json({ success: true, message: 'Medicamento eliminado exitosamente' });
  } catch (error) {
    console.error('Error al eliminar el medicamento:', error);
    res.status(500).json({ error: 'Error al eliminar el medicamento' });
  }
});




// Ruta con un PA para agregar medicamentos
router.post('/agregar-medicamento', async (req, res) => {
  try {
    const {
      nombre_medicamento,
      no_lote,
      id_producto_tm,
      id_tipo_medicamento,
      img,
      precio,
      existencias,
      fecha_vencimiento,
      fecha_laboracion
    } = req.body;

    const connection = await oracledb.getConnection(dbConfig);

    const plsqlBlock = `
    BEGIN
      PA_AgregarMedicamento(
        p_nombre_medicamento => :nombre_medicamento,
        p_no_lote => :no_lote,
        p_id_producto_tm => :id_producto_tm,
        p_id_tipo_medicamento => :id_tipo_medicamento,
        p_img => :img,
        p_precio => :precio,
        p_existencias => :existencias,
        p_fecha_vencimiento => :fecha_vencimiento,
        p_fecha_laboracion => :fecha_laboracion
      );
    END;
    `;

    await connection.execute(plsqlBlock, {
      nombre_medicamento,
      no_lote,
      id_producto_tm,
      id_tipo_medicamento,
      img,
      precio,
      existencias,
      fecha_vencimiento,
      fecha_laboracion
    });

    connection.close();

    res.json({ success: true, message: 'Medicamento agregado exitosamente' });
  } catch (error) {
    console.error('Error al agregar medicamento:', error);
    res.status(500).json({ error: 'Error al agregar medicamento' });
  }
});







module.exports = router;
















































