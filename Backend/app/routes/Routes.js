

const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');
const app = express();
app.use(express.json());


module.exports = router;


const dbConfig = {
  user: 'ADMIN',
  password: 'admin',
  connectString: 'localhost:1521/xe'
};





router.get('/consultar-Empleados', async (req, res) => {
  try {
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');
    
    const result = await connection.execute('SELECT * FROM Empleados');
    connection.close();

    res.json(result.rows);
  } catch (error) {
    console.error('Error al realizar la consulta:', error);
    res.status(500).json({ error: 'Error al realizar la consulta' });
  }
});

router.post('/consultar-Usuario/:usuario', async (req, res) => {
  try {
    // dbConfig.user
    // dbConfig.password
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');
    
    const result = await connection.execute('SELECT * FROM Empleados');
    connection.close();
    console.log(req.body);
    res.json(result.rows);
  } catch (error) {
    console.error('Error al realizar la consulta:', error);
    res.status(500).json({ error: 'Error al realizar la consulta' });
  }
});






app.post('/cliente/crearCliente', async (req, res) => {
  try {
    const {
      ID_Empleado,
      Usuario,
      Password,
      Salario
    } = req.body;
    console.log(req.body);
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `
      INSERT INTO Empleados (ID_Empleado, USUARIO, PASSWORD, SALARIO) VALUES (:ID_Empleado, :Usuario, :Password, :Salario)
      `,
      {
        ID_Empleado,
        Usuario,
        Password,
        Salario
      },
      {
        autoCommit: true
      }
    );

    await connection.close();

    res.json({ message: 'Cliente creado exitosamente.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error al crear el cliente.' });
  }
});


app.delete('/cliente/eliminarCliente/:ID_Empleado', async (req, res) => {
  try {
    const { ID_Empleado } = req.params;
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `
      DELETE FROM Empleados WHERE ID_Empleado = :ID_Empleado
      `,
      {
        ID_Empleado
      },
      {
        autoCommit: true
      }
    );

    await connection.close();

    if (result.rowsAffected === 1) {
      res.json({ message: 'Cliente eliminado exitosamente.' });
    } else {
      res.status(404).json({ message: 'Cliente no encontrado.' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error al eliminar el cliente.' });
  }
});



app.listen(3000, () => console.log('Server started on port 3000'));
















