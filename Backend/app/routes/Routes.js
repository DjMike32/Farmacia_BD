
const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');
const app = express();
app.use(express.json());
const bodyParser = require("body-parser"); router.use(bodyParser.json());
app.use((req, res, next) => {
  console.log(`Solicitud a: ${req.method} ${req.url}`);
  next(); 
});

// Rutas
app.use('/', router); 
app.use(express.static("Frontend"));
app.use(express.json());

module.exports = router;

const dbConfig = {
  user: 'Michael',
  password: 'admin',
  connectString: 'localhost:1521/xe'
};



router.post('/login', async (req, res) => {
  try {
    const { usuario, password } = req.body;

    // Realizar una consulta a la base de datos para verificar las credenciales
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      'SELECT COUNT(*) AS count FROM Empleados WHERE Usuario = :usuario AND Password = :password',
      [usuario, password]
    );
    connection.close();

    const count = result.rows[0].COUNT;
    if (count > 0) {
      res.json({ success: true });
    } else {
      res.json({ success: false });
    }
  } catch (error) {
    console.error('Error en inicio de sesión:', error);
    res.status(500).json({ success: false });
  }
});


router.get('/medicamento', async (req, res) => {
  try {
      // Realizar la consulta a la base de datos para obtener todos los valores de Medicamentos
      const connection = await oracledb.getConnection(dbConfig);
      const result = await connection.execute(
          'SELECT * FROM Medicamento'
      );
      connection.close();

      // Enviar los resultados como respuesta JSON
      res.json(result.rows);
  } catch (error) {
      console.error('Error al obtener medicamentos:', error);
      res.status(500).json({ success: false, message: 'Error al obtener medicamentos' });
  }
});








module.exports = router;


app.listen(3000, () => console.log('Server started on port 3000'));










// // Ruta para consultar empleados
// router.get('/consultar-Empleados', async (req, res) => {
//   try {
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
//     console.log('Conexión a Oracle exitosa');
    
//     const result = await connection.execute('SELECT * FROM Empleados');
//     connection.close();

//     res.json(result.rows);
//   } catch (error) {
//     console.error('Error al realizar la consulta:', error);
//     res.status(500).json({ error: 'Error al realizar la consulta' });
//   }
// });


// router.get('/consultar-Usuario/:usuario', async (req, res) => {
//   try {
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
//     console.log('Conexión a Oracle exitosa');
//     const result = await connection.execute('SELECT * FROM Pais WHERE ID_Pais = :usuario');
//     connection.close();
//     console.log(req.body);
//     res.json(result.rows);
//   } catch (error) {
//     console.error('Error al realizar la consulta:', error);
//     res.status(500).json({ error: 'Error al realizar la consulta' });
//   }
// });






// app.post('/cliente/crearCliente', async (req, res) => {
//   try {
//     const {
//       // ID_Empleado,
//       // Usuario,
//       // Password,
//       // Salario
//       Descripcion,
//       Color
//     } = req.body;
//     console.log(req.body);
//     const connection = await oracledb.getConnection(dbConfig);

//     const result = await connection.execute(
//       `
//       INSERT INTO Pais (Descripcion, Color) VALUES (:Descripcion, :Color)
//       `,
//       {
//         // ID_Empleado,
//         // Usuario,
//         // Password,
//         // Salario
//         Descripcion,
//         Color
//       },
//       {
//         autoCommit: true
//       }
//     );

//     await connection.close();

//     res.json({ message: 'Cliente creado exitosamente.' });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ message: 'Error al crear el cliente.' });
//   }
// });


// app.delete('/cliente/eliminarCliente/:ID_Empleado', async (req, res) => {
//   try {
//     const { ID_Empleado } = req.params;
//     const connection = await oracledb.getConnection(dbConfig);

//     const result = await connection.execute(
//       `
//       DELETE FROM Empleados WHERE ID_Empleado = :ID_Empleado
//       `,
//       {
//         ID_Empleado
//       },
//       {
//         autoCommit: true
//       }
//     );

//     await connection.close();

//     if (result.rowsAffected === 1) {
//       res.json({ message: 'Cliente eliminado exitosamente.' });
//     } else {
//       res.status(404).json({ message: 'Cliente no encontrado.' });
//     }
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ message: 'Error al eliminar el cliente.' });
//   }
// });




// router.post('/login', async (req, res) => {
//   try {
//     const { Descripcion, Color } = req.body;

//     // Realizar una consulta a la base de datos para verificar las credenciales
//     const connection = await oracledb.getConnection(dbConfig);
//     const result = await connection.execute(
//       'SELECT COUNT(*) AS count FROM Pais WHERE Descripcion =:Descripcion AND Color =:Color',
//       [Descripcion, Color]
//     );
//     connection.close();

//     const count = result.rows[0].COUNT;
//     if (count > 0) {
//       res.json({ success: true });
//     } else {
//       res.json({ success: false });
//     }
//   } catch (error) {
//     console.error('Error en inicio de sesión:', error);
//     res.status(500).json({ success: false });
//   }
// });





