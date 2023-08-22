



const express = require('express');
const Routes = require('./routes/Routes');
const oracledb = require('oracledb');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3001;

// Middleware para registrar solicitudes en la consola
app.use((req, res, next) => {
  console.log(`Solicitud a: ${req.method} ${req.url}`);
  next(); 
});

// Middleware para analizar el cuerpo de la solicitud en formato JSON
app.use(express.json());

// Habilitar CORS para todas las rutas
app.use(cors());

// Configurar las rutas
app.use('/', Routes);

// Servir archivos estáticos desde el directorio "Frontend"
app.use(express.static("Frontend"));

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



