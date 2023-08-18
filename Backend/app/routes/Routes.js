

const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');


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


router.post('/agregar-Empleado', async (req, res) => {
  const { Usuario, Password, Salario } = req.body;

  try {
    const connection = await oracledb.getConnection();
    const result = await connection.execute(
      'INSERT INTO Empleados (Usuario, Password, Salario) VALUES (:Usuario, :Password, :Salario)',
      { Usuario, Password, Salario }
    );
    await connection.commit();
    await connection.close();

    res.status(200).json({ mensaje: 'Empleado agregado exitosamente' });
  } catch (error) {
    console.error('Error al agregar empleado:', error);
    res.status(500).json({ error: 'Error al agregar empleado' });
  }
});
















