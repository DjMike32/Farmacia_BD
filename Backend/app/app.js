
const express = require('express');
const Routes = require('./routes/Routes');
const oracledb = require('oracledb');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3001;
const bodyParser = require("body-parser"); Routes.use(bodyParser.json());
app.use(cors()); // Habilitar CORS para todas las rutas

// Middleware para registrar solicitudes en la consola
app.use((req, res, next) => {
  console.log(`Solicitud a: ${req.method} ${req.url}`);
  next(); 
});

// Rutas
app.use('/', Routes); 
app.use(express.static("Frontend"));
app.use(express.json());

const dbConfig = {
  user: 'Michael',
  password: 'admin',
  connectString: 'localhost:1521/xe'
};

async function connectToOracle() {
  try {
    await oracledb.createPool(dbConfig);
    console.log('Pool de conexiones creado');
  } catch (error) {
    console.error('Error al crear el pool de conexiones:', error);
  }
}

connectToOracle();

app.listen(PORT, () => {
  console.log(`Servidor Express iniciado en el puerto ${PORT}`);
});


// app.post('/cliente/crearCliente', async (req, res) => {
//   try {
//     const {
//       ID_Empleado,
//       Usuario,
//       Password,
//       Salario
//     } = req.body;
//     console.log(req.body);
//     const connection = await oracledb.getConnection(dbConfig);

//     const result = await connection.execute(
//       `
//       INSERT INTO Empleados (ID_Empleado, USUARIO, PASSWORD, SALARIO) VALUES (:ID_Empleado, :Usuario, :Password, :Salario)
//       `,
//       {
//         ID_Empleado,
//         Usuario,
//         Password,
//         Salario
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














// const express = require('express');
// const Routes = require('./routes/Routes');
// const oracledb = require('oracledb');
// const cors = require('cors');
// const app = express();
// const PORT = process.env.PORT || 3001;
// const bodyParser = require("body-parser"); Routes.use(bodyParser.json());
// app.use(cors()); // Habilitar CORS para todas las rutas

// // Middleware para registrar solicitudes en la consola
// app.use((req, res, next) => {
//   console.log(`Solicitud a: ${req.method} ${req.url}`);
//   next(); 
// });

// // Rutas
// app.use('/', Routes); 
// app.use(express.static("Frontend"));
// app.use(express.json());

// const dbConfig = {
//   user: 'Michael',
//   password: 'admin',
//   connectString: 'localhost:1521/xe'
// };

// async function connectToOracle() {
//   try {
//     await oracledb.createPool(dbConfig);
//     console.log('Pool de conexiones creado');
//   } catch (error) {
//     console.error('Error al crear el pool de conexiones:', error);
//   }
// }

// connectToOracle();

// app.listen(PORT, () => {
//   console.log(`Servidor Express iniciado en el puerto ${PORT}`);
// });



// // app.post('/cliente/crearCliente', async (req, res) => {
// //   try {
// //     const {
// //       ID_Empleado,
// //       Usuario,
// //       Password,
// //       Salario
// //     } = req.body;
// //     console.log(req.body);
// //     const connection = await oracledb.getConnection(dbConfig);

// //     const result = await connection.execute(
// //       `
// //       INSERT INTO Empleados (ID_Empleado, USUARIO, PASSWORD, SALARIO) VALUES (:ID_Empleado, :Usuario, :Password, :Salario)
// //       `,
// //       {
// //         ID_Empleado,
// //         Usuario,
// //         Password,
// //         Salario
// //       },
// //       {
// //         autoCommit: true
// //       }
// //     );

// //     await connection.close();

// //     res.json({ message: 'Cliente creado exitosamente.' });
// //   } catch (err) {
// //     console.error(err);
// //     res.status(500).json({ message: 'Error al crear el cliente.' });
// //   }
// // });








  