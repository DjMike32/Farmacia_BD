
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







router.get('/consultar-Empleados', async (req, res) => {
  try {
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');
    
    const result = await connection.execute('SELECT * FROM Empleados');
    connection.close();

    res.json(result.rows);
    console.log(result.rows);
  } catch (error) {
    console.error('Error al realizar la consulta:', error);
    res.status(500).json({ error: 'Error al realizar la consulta' });
  }
});



router.get('/consultar-Usuario/:usuario', async (req, res) => {
  try {
    const usuario = req.params.usuario; // Obtener el parámetro 'usuario' de la URL
    
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');
    
    const result = await connection.execute('SELECT * FROM Empleados WHERE ID_Empleado = :usuario', [usuario]);
    connection.close();
    
    console.log(result.rows);
    res.json(result.rows);
  } catch (error) {
    console.error('Error al realizar la consulta:', error);
    res.status(500).json({ error: 'Error al realizar la consulta' });
  }
});


router.get('/consultar-medicamento', async (req, res) => {
  try {
    // const medicamento = req.params.medicamento; 
    
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');
    
    const result = await connection.execute('SELECT * FROM Medicamento' 
    // [medicamento]
    );
    connection.close();
    
    console.log(result.rows);
    res.json(result.rows);
  } catch (error) {
    console.error('Error al realizar la consulta:', error);
    res.status(500).json({ error: 'Error al realizar la consulta' });
  }
});


// router.get('/llamar-procedimiento', async (req, res) => {
//   try {
//     const v_nombre_patron = req.query.nombre_patron; // Obtén el valor desde la consulta

//     // Realiza la conexión a la base de datos
//     const connection = await oracledb.getConnection(dbConfig);

//     // Ejecuta el procedimiento almacenado
//     await connection.execute(
//       `
//       BEGIN
//         PA_BuscarMedicamentoPorNombre(p_nombre_patron => :v_nombre_patron);
//       END;
//       `,
//       {
//         v_nombre_patron: v_nombre_patron // Pasa el valor del patrón como parámetro
//       }
//     );

//     connection.close();
//     res.json({ success: true });
//   } catch (error) {
//     console.error('Error al llamar al procedimiento:', error);
//     res.status(500).json({ success: false, error: error.message });
//   }
// });


router.post('/llamar-procedimiento2', async (req, res) => {
  try {
    const v_nombre_patron = req.body.nombre_patron; // Obtén el valor desde el cuerpo de la solicitud

    // Realiza la conexión a la base de datos
    const connection = await oracledb.getConnection(dbConfig);

    // Ejecuta el procedimiento almacenado
    await connection.execute(
      `
      BEGIN
        PA_BuscarMedicamentoPorNombre(p_nombre_patron => :v_nombre_patron);
      END;
      `,
      {
        v_nombre_patron: v_nombre_patron // Pasa el valor del patrón como parámetro
      }
    );

    connection.close();
    res.json({ success: true });
  } catch (error) {
    console.error('Error al llamar al procedimiento:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});


router.get('/llamar-procedimiento', async (req, res) => {
  try {
    const v_nombre_patron = req.query.nombre_patron;

    // Realiza la conexión a la base de datos
    const connection = await oracledb.getConnection(dbConfig);

    // Ejecuta el procedimiento almacenado y obtén el resultado
    const result = await connection.execute(
      `
      SET SERVEROUTPUT ON;
      DECLARE
        v_resultado VARCHAR2(100);
      BEGIN
        PA_BuscarMedicamentoPorNombre(p_nombre_patron => :v_nombre_patron, p_resultado => v_resultado);
        :resultado := v_resultado;
      END;
      `,
      {
        v_nombre_patron: v_nombre_patron

      }
    );

    connection.close();
    const resultado = result.outBinds.resultado;
    console.log('Resultado del procedimiento:', resultado);
    res.json({ success: true, resultado: resultado });
  } catch (error) {
    console.error('Error al llamar al procedimiento:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});





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






















