
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

// document.getElementById('crearEmpleadoForm').addEventListener('submit', function(event) {
//   event.preventDefault();

//   const idEmpleado = document.getElementById('idEmpleado').value;
//   const usuario = document.getElementById('usuario').value;
//   const password = document.getElementById('password').value;
//   const salario = document.getElementById('salario').value;

//   const nuevoEmpleado = {
//     ID_Empleado: idEmpleado,
//     Usuario: usuario,
//     Password: password,
//     Salario: salario
//   };

//   axios.post('/cliente/crearCliente', nuevoEmpleado)
//     .then(response => {
//       console.log(response.data);
//       alert('Empleado creado exitosamente');
//     })
//     .catch(error => {
//       console.error('Error:', error);
//       alert('Error al crear el empleado');
//     });
// });


// document.getElementById('crearEmpleadoFormulario').addEventListener('submit', function(event) {
//   event.preventDefault();

//   // const idEmpleado = document.getElementById('idEmpleado').value;
//   // const usuario = document.getElementById('usuario').value;
//   // const password = document.getElementById('password').value;
//   // const salario = document.getElementById('salario').value;

//   const Descripcion = document.getElementById('usuario').value;
//   const Color = document.getElementById('password').value;
 


//   const nuevoEmpleado = {
//     // ID_Empleado: idEmpleado,
//     // Usuario: usuario,
//     // Password: password,
//     // Salario: salario
//     Descripcion: Descripcion,
//     Color: Color 
//   };

//   fetch('/cliente/crearCliente', {
//     method: 'POST',
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: JSON.stringify(nuevoEmpleado)
//   })
//     .then(response => response.json())
//     .then(data => {
//       console.log(data);
//       alert('Empleado creado exitosamente');
//     })
//     .catch(error => {
//       console.error('Error:', error);
//       alert('Error al crear el empleado');
//     });
// });



// document.getElementById('loginForm').addEventListener('submit', function(event) {
//   event.preventDefault();

//   const Descripcion = document.getElementById('usuario').value;
//   const Color = document.getElementById('password').value;

//   const credenciales = {
//     Descripcion: Descripcion,
//     Color: Color 
//   };

//   fetch('/login', {
//     method: 'POST',
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: JSON.stringify(credenciales)
//   })
//     .then(response => response.json())
//     .then(data => {
//       if (data.success) {
//         alert('Inicio de sesión exitoso');
//       } else {
//         alert('Credenciales incorrectas');
//       }
//     })
//     .catch(error => {
//       console.error('Error:', error);
//       alert('Error al iniciar sesión');
//     });
// });

document.getElementById('loginForm').addEventListener('submit', function(event) {
  event.preventDefault();

  const Descripcion = document.getElementById('usuario').value;
  const Color = document.getElementById('password').value;

  console.log('Descripcion:', Descripcion);
  console.log('Color:', Color);

  const credenciales = {
    Descripcion: Descripcion,
    Color: Color 
  };

  fetch('/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(credenciales)
  })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert('Inicio de sesión exitoso');
      } else {
        alert('Credenciales incorrectas');
      }
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Error al iniciar sesión');
    });
});



