
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


module.exports = router;


const dbConfig = {
  user: 'Michael',
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
    connection.close();
  
    res.json({ success: true, message: 'Inserción exitosa' });
  } catch (error) {
    console.error('Error al realizar la inserción:', error);
    res.status(500).json({ error: 'Error al realizar la inserción' });
  }
});


app.post('/cliente/crearCliente', async (req, res) => {
  try {
    const {
      // ID_Empleado,
      // Usuario,
      // Password,
      // Salario
      Descripcion,
      Color
    } = req.body;
    console.log(req.body);
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `
      INSERT INTO Pais (Descripcion, Color) VALUES (:Descripcion, :Color)
      `,
      {
        // ID_Empleado,
        // Usuario,
        // Password,
        // Salario
        Descripcion,
        Color
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

router.post('/login', async (req, res) => {
  try {
    const { usuario, password } = req.body;

    // Realizar una consulta a la base de datos para verificar las credenciales
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      'SELECT * FROM Pais WHERE Descripcion = :Descripcion AND Color = :password',
      [usuario, password]
    );
    connection.close();

    if (result.rows.length > 0) {
      res.json({ success: true });
    } else {
      res.json({ success: false });
    }
  } catch (error) {
    console.error('Error en inicio de sesión:', error);
    res.status(500).json({ success: false });
  }
});


module.exports = router;

app.listen(3000, () => console.log('Server started on port 3000'));
























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




// // Rutas
// app.use('/', router); 
// app.use(express.static("Frontend"));
// app.use(express.json());





// const dbConfig = {
//   user: 'Michael',
//   password: 'admin',
//   connectString: 'localhost:1521/xe'
// };


//  //------------Consultas----------------//


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


// router.get('/consultar-Medicamentos', async (req, res) => {
//   try {
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
//     console.log('Conexión a Oracle exitosa');
    
//     const result = await connection.execute('SELECT * FROM Medicamento');
//     connection.close();

//     res.json(result.rows);
//   } catch (error) {
//     console.error('Error al realizar la consulta:', error);
//     res.status(500).json({ error: 'Error al realizar la consulta' });
//   }
// });

// router.get('/consultar-Factura', async (req, res) => {
//   try {
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
//     console.log('Conexión a Oracle exitosa');
    
//     const result = await connection.execute('SELECT * FROM Factura');
//     connection.close();

//     res.json(result.rows);
//   } catch (error) {
//     console.error('Error al realizar la consulta:', error);
//     res.status(500).json({ error: 'Error al realizar la consulta' });
//   }
// });

// router.get('/consultar-Suplementos', async (req, res) => {
//   try {
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
//     console.log('Conexión a Oracle exitosa');
    
//     const result = await connection.execute('SELECT * FROM Suplementos');
//     connection.close();

//     res.json(result.rows);
//   } catch (error) {
//     console.error('Error al realizar la consulta:', error);
//     res.status(500).json({ error: 'Error al realizar la consulta' });
//   }
// });


// // -----------------Insertar -------------------//


// router.post('/insertar-Suplemento', async (req, res) => {
//   try {
//     const { descripcion, id_producto, id_tipo_medicamento, img, precio, existencias, fecha_vencimiento, fecha_laboracion } = req.body;
    
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
//     console.log('Conexión a Oracle exitosa');

//     // Realizar la inserción en la tabla Suplementos
//     await connection.execute(
//       'INSERT INTO Suplementos (Descripcion, ID_producto, ID_tipo_medicamento, Img, precio, existencias, fecha_vencimiento, fecha_laboracion) VALUES (:descripcion, :id_producto, :id_tipo_medicamento, :img, :precio, :existencias, TO_DATE(:fecha_vencimiento, \'YYYY-MM-DD\'), TO_DATE(:fecha_laboracion, \'YYYY-MM-DD\'))',
//       [descripcion, id_producto, id_tipo_medicamento, img, precio, existencias, fecha_vencimiento, fecha_laboracion]
//     );

//     connection.close();
    
//     res.json({ success: true, message: 'Inserción exitosa' });
//   } catch (error) {
//     console.error('Error al realizar la inserción:', error);
//     res.status(500).json({ error: 'Error al realizar la inserción' });
//   }
// });

// // router.post('/insertar-Pais', async (req, res) => {
// //   try {
// //     const { descripcion } = req.body;
    
// //     console.log('Intentando conectar a Oracle...');
// //     const connection = await oracledb.getConnection();
// //     console.log('Conexión a Oracle exitosa');

// //     // Realizar la inserción en la tabla Pais
// //     await connection.execute(
// //       'INSERT INTO Pais (Descripcion) VALUES (:descripcion)',
// //       [descripcion]
// //     );

// //     connection.close();
    
// //     res.json({ success: true, message: 'Inserción exitosa' });
// //   } catch (error) {
// //     console.error('Error al realizar la inserción:', error);
// //     res.status(500).json({ error: 'Error al realizar la inserción' });
// //   }
// // });


// router.post('/insertar-Pais', async (req, res) => {
//   try {
//     const { descripcion } = req.body;
    
//     console.log('Intentando conectar a Oracle...');
//     const connection = await oracledb.getConnection();
    
//     console.log('Conexión a Oracle exitosa');
    
//     // Realizar la inserción en la tabla Pais
//     await connection.execute(
//       'INSERT INTO Pais (Descripcion) VALUES (:descripcion)',
//       [descripcion]
//     );
//     connection.close();
  
//     res.json({ success: true, message: 'Inserción exitosa' });
//   } catch (error) {
//     console.error('Error al realizar la inserción:', error);
//     res.status(500).json({ error: 'Error al realizar la inserción' });
//   }
// });








// router.post('/login', async (req, res) => {
//   try {
//     const { usuario, password } = req.body;

//     // Realizar una consulta a la base de datos para verificar las credenciales
//     const connection = await oracledb.getConnection(dbConfig);
//     const result = await connection.execute(
//       'SELECT * FROM Pais WHERE Descripcion = :Descripcion AND Color = :password',
//       [usuario, password]
//     );
//     connection.close();

//     if (result.rows.length > 0) {
//       res.json({ success: true });
//     } else {
//       res.json({ success: false });
//     }
//   } catch (error) {
//     console.error('Error en inicio de sesión:', error);
//     res.status(500).json({ success: false });
//   }
// });



// module.exports = router;
// app.listen(3000, () => console.log('Server started on port 3000'));






















