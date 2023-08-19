
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

const cargarUsuarios = async () => {
  try {
    const respuesta = await fetch('/consultar-Empleados');
    const usuarios = await respuesta.json();
    console.log(usuarios);
  } catch (error) {
    console.error('Error al cargar usuarios:', error);
  }
};




const IniciarSesion = async () => {
  try {
    /** Obteniene datos para ingresas */
    let user = document.getElementById('username').value;
    let password = document.getElementById('password').value;
    
    const respuesta = await fetch('/consultar-Usuario/:usuario');
    const usuarios = await respuesta.json();
    console.log( user, password);
  } catch (error) {
    console.error('Error al cargar usuarios:', error);
  }
};


//cargarUsuarios();


// Llamado a fetch para crear un empleado
const crearEmpleado = async (Usuario, Password, Salario) => {
  try {
    const respuesta = await fetch('/crear-Empleado', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({Usuario, Password, Salario })
    });

    const resultado = await respuesta.json();

    if (respuesta.ok) {
      console.log(resultado.mensaje); // Empleado creado exitosamente
      // Actualizar la lista de usuarios después de la creación exitosa
      cargarUsuarios();
    } else {
      console.error(resultado.error); // Error al crear empleado
    }
  } catch (error) {
    console.error('Error al crear empleado:', error);
  }
};









