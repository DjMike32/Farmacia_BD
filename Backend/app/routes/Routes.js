

const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');
const app = express();
app.use(express.json());


module.exports = router;

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


const dbConfig = {
  user: 'Michael',
  password: 'admin',
  connectString: 'localhost:1521/xe'
};


router.post('/agregar-Empleado', async (req, res) => {
  console.log(req.body);
  try {
    const { ID_Empleado, Usuario, Password, Salario } = req.body;
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      `
      INSERT INTO Empleados (ID_Empleado, USUARIO, PASSWORD, SALARIO) VALUES (:ID_Empleado, :Usuario, :Password, :Salario)
      `
      ,{ ID_Empleado, Usuario, Password, Salario }
    );
    await connection.commit();
    await connection.close();

    res.status(200).json({ mensaje: 'Empleado agregado exitosamente' });
  } catch (error) {
    console.error('Error al agregar empleado:', error);
    res.status(500).json({ error: 'Error al agregar empleado' });
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

    const result = await connection.execute(`
    'INSERT INTO Empleados (ID_Empleado, USUARIO, PASSWORD, SALARIO) VALUES (:ID_Empleado, :Usuario, :Password, :Salario);'
    `, {
      ID_Empleado,
      Usuario,
      Password,
      Salario
    }, {
      autoCommit: true
    });

    await connection.close();

    res.json({ message: 'Cliente creado exitosamente.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error al crear el cliente.' });
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


app.listen(3000, () => console.log('Server started on port 3000'));















