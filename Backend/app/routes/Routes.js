

const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');

// Ruta para consultar la tabla 'Pais'
router.get('/consultar-Pais', async (req, res) => {
  try {
    console.log('Intentando conectar a Oracle...');
    const connection = await oracledb.getConnection();
    console.log('Conexión a Oracle exitosa');
    
    const result = await connection.execute('SELECT * FROM Direccion');
    connection.close();

    res.json(result.rows);
  } catch (error) {
    console.error('Error al realizar la consulta:', error);
    res.status(500).json({ error: 'Error al realizar la consulta' });
  }
});

module.exports = router;



