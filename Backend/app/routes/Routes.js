
// const express = require('express');
// const router = express.Router();
// const oracledb = require('oracledb');
// const app = express();
// app.use(express.json());
// const bodyParser = require("body-parser"); router.use(bodyParser.json());
// app.use((req, res, next) => {
//   console.log(`Solicitud a: ${req.method} ${req.url}`);
//   next(); 
// });

// const dbConfig = {
//   user: 'Michael',
//   password: 'admin',
//   connectString: 'localhost:1521/xe'
// };


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













module.exports = router;
















































