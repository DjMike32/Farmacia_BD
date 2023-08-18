// let Usuarios = {}
// let Medicamentos ={}

// const cargarUsuarios= async () => {
//     const respuesta = await fetch('/consultar-Empleados', {
//         method: "get"});
//         Usuarios = await respuesta.json();
//         console.log(Usuarios);
//     }

// const cargarMedicamentos= async () => {
//     const respuesta = await fetch('/consultar-Medicamentos', {
//         method: "get"});
//         Medicamentos = await respuesta.json();
//         console.log(Medicamentos);
//     }    
    
// cargarUsuarios();
// cargarMedicamentos();

const axios = require('axios');

// Función para cargar usuarios usando axios
const cargarUsuarios = async () => {
  try {
    const respuesta = await axios.get('/consultar-Empleados');
    const Usuarios = respuesta.data;
    console.log(Usuarios);
  } catch (error) {
    console.error('Error al cargar usuarios:', error);
  }
};

// Función para cargar medicamentos usando axios
const cargarMedicamentos = async () => {
  try {
    const respuesta = await axios.get('/consultar-Medicamentos');
    const medicamentos = respuesta.data;
    console.log(medicamentos);
  } catch (error) {
    console.error('Error al cargar medicamentos:', error);
  }
};

// Llamar a las funciones para cargar usuarios y medicamentos
cargarUsuarios();
// cargarMedicamentos();
