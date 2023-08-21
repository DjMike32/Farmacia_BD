
const cargarUsuarios = async () => {
  try {
    const respuesta = await fetch('/consultar-Empleados');
    const usuarios = await respuesta.json();
    console.log(usuarios);
  } catch (error) {
    console.error('Error al cargar usuarios:', error);
  }
};

// Medicamentos = [];

cargarUsuarios();

// const cargarMedicamentos = async () => {
//   try {
//     const respuesta = await fetch('/consultar-medicamento');
//     const medicamentos = await respuesta.json();
//     console.log(medicamentos);
//   } catch (error) {
//     console.error('Error al cargar usuarios:', error);
//   }
// };

// cargarMedicamentos();

const cargarMedicamentos = async () => {
  try {
    const respuesta = await fetch('/consultar-medicamento');
    const medicamentos = await respuesta.json();
    
    // Aquí asignamos los datos obtenidos al arreglo de objetos JSON
    const arregloDeMedicamentos = medicamentos;

    // Ahora puedes trabajar con el arreglo de objetos JSON como necesites
    console.log(arregloDeMedicamentos);
  } catch (error) {
    console.error('Error al cargar medicamentos:', error);
  }
};


cargarMedicamentos();


const medicamentos = [
  { ID_Medicamento: 1, Nombre_Medicamento: 'Medicamento A', Existencias: 100 },
  { ID_Medicamento: 2, Nombre_Medicamento: 'Medicamento B', Existencias: 50 },
  { ID_Medicamento: 3, Nombre_Medicamento: 'Medicamento C', Existencias: 200 }
];










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



document.getElementById('loginForm').addEventListener('submit', function(event) {
  event.preventDefault();

  const usuario = document.getElementById('usuario').value;
  const password = document.getElementById('password').value;

  const credenciales = {
    usuario: usuario,
    password: password 
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

// document.getElementById('loginForm').addEventListener('submit', function(event) {
//   event.preventDefault();

//   const Usuario = document.getElementById('usuario').value;
//   const Password = document.getElementById('password').value;

//   console.log('Usuario:', Usuario);
//   console.log('Password:', Password);

//   const credenciales = {
//     Usuario: Usuario,
//     Password: Password 
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

function redireccionar() {
  // Redirige al usuario a la página de destino
  window.location.href = "admiMenu.html";
  setTimeout(function() {
    window.location.href = "pagina_destino.html";
}, 2000);
}


document.getElementById('loginForm').addEventListener('submit', function(event) {
  event.preventDefault();

  const usuario = document.getElementById('usuario').value;
  const password = document.getElementById('password').value;

  const credenciales = {
    usuario: usuario,
    password: password
  };

    console.log('Usuario:', usuario);
  console.log('Password:', password);

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
      // console.error('Error:', error);
      // alert('Error al iniciar sesión');
    });
    redireccionar();
});


    // Arreglo para almacenar los datos de medicamentos
    // var medicamentos = [];

    // Función para obtener los datos de la base de datos
    async function obtenerDatosMedicamentos() {
        try {
            const response = await fetch('/medicamento'); // Reemplaza con la ruta correcta
            const data = await response.json();
            medicamentos = data;
            generarFilasTabla();
        } catch (error) {
            console.error('Error al obtener los datos:', error);
        }
    }

    // Llamada a la función para obtener los datos
    obtenerDatosMedicamentos();

    // Función para generar las filas de la tabla con los datos obtenidos
    // function generarFilasTabla() {
    //     var tabla = document.getElementById("tabla-medicamentos");

    //     medicamentos.forEach(function(medicamento) {
    //         var fila = tabla.insertRow();

    //         fila.insertCell().textContent = medicamento.ID_Medicamentos;
    //         fila.insertCell().textContent = medicamento.Descripcion;
    //         fila.insertCell().textContent = medicamento.Nombre_Medicamento;
    //         fila.insertCell().textContent = medicamento.Fecha_Vencimiento;
    //         fila.insertCell().textContent = medicamento.Fecha_Laboracion;
    //         fila.insertCell().textContent = medicamento.Prohibiciones;
    //         fila.insertCell().textContent = medicamento.Existencias;
    //         fila.insertCell().textContent = medicamento.ID_Drogueria;
    //         fila.insertCell().textContent = medicamento.Nombre_Medicamento;
    //         fila.insertCell().textContent = medicamento.No_Lote;
    //         fila.insertCell().textContent = medicamento.ID_Tipo_Medicamento;
    //     });
    // }





