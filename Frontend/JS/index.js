
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


document.addEventListener('DOMContentLoaded', () => {
  const btnAbrirModal = document.getElementById('btnAbrirModal');
  const modalAgregarMedicamento = document.getElementById('modalAgregarMedicamento');
  const agregarMedicamentoForm = document.getElementById('agregarMedicamentoForm');

  // Abrir la ventana modal al hacer clic en el botón
  btnAbrirModal.addEventListener('click', () => {
    modalAgregarMedicamento.style.display = 'block';
  });

  // Cerrar la ventana modal al hacer clic en la "x"
  modalAgregarMedicamento.querySelector('.modal-close').addEventListener('click', () => {
    modalAgregarMedicamento.style.display = 'none';
  });

  // Enviar datos del formulario al servidor
  agregarMedicamentoForm.addEventListener('submit', async (event) => {
    event.preventDefault();

    const formData = new FormData(agregarMedicamentoForm);
    const data = Object.fromEntries(formData.entries());

    try {
      const response = await fetch('http://localhost:3001/agregar-medicamento', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        console.log('Medicamento agregado exitosamente');
        modalAgregarMedicamento.style.display = 'none'; // Cerrar la ventana modal
        // Aquí podrías agregar código para actualizar la tabla
      } else {
        console.error('Error al agregar el medicamento');
      }
    } catch (error) {
      console.error('Error al agregar el medicamento:', error);
    }
  });
});



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









document.addEventListener('DOMContentLoaded', async () => {
  const tablaMedicamentos = document.getElementById('tablaMedicamentos');
  
  try {
    const response = await fetch('http://localhost:3001/obtener-todos-medicamentos'); // Cambia la URL si es diferente
    
    if (response.ok) {
      const data = await response.json();
      console.log(data); // Verifica la estructura de los datos aquí
      
      const tbody = tablaMedicamentos.querySelector('tbody');
      
      // Limpiar el contenido actual de la tabla
      tbody.innerHTML = '';

      data.data.forEach(medicamento => {
        const row = document.createElement('tr');
        row.setAttribute('data-id', medicamento[0]);

        // Recorrer los valores del arreglo y crear las celdas
        medicamento.forEach((valor, index) => {
          const cell = document.createElement('td');
          if (index === 8 || index === 9) { // Índices correspondientes a las fechas
            // Formatear las fechas antes de asignarlas a la celda
            const formattedDate = new Date(valor).toLocaleDateString('es-ES');
            cell.textContent = formattedDate;
          } else {
            cell.textContent = valor;
          }
          row.appendChild(cell);
        });

        // Agregar la celda del botón de eliminar
        const eliminarCell = document.createElement('td');
        const eliminarBtn = document.createElement('button');
        eliminarBtn.textContent = 'Eliminar';
        eliminarBtn.classList.add('eliminar-btn');
        eliminarCell.appendChild(eliminarBtn);
        row.appendChild(eliminarCell);

        tbody.appendChild(row);
      });
    } else {
      console.error('Error al obtener los medicamentos');
    }
  } catch (error) {
    console.error('Error al cargar medicamentos:', error);
  }
});



// document.addEventListener('DOMContentLoaded', () => {
//   const modalAgregarMedicamento = document.getElementById('modalAgregarMedicamento');
//   const btnAbrirModal = document.getElementById('btnAbrirModal');
//   const btnCerrarModal = modalAgregarMedicamento.querySelector('.modal-close');
  
//   const agregarMedicamentoForm = document.getElementById('agregarMedicamentoForm');
  
//   btnAbrirModal.addEventListener('click', () => {
//     modalAgregarMedicamento.style.display = 'flex';
//   });
  
//   btnCerrarModal.addEventListener('click', () => {
//     modalAgregarMedicamento.style.display = 'none';
//   });
  
//   agregarMedicamentoForm.addEventListener('submit', async (event) => {
//     event.preventDefault();
    
//     const formData = new FormData(agregarMedicamentoForm);
//     const data = {};
    
//     formData.forEach((value, key) => {
//       data[key] = value;
//     });

//     console.log(formData);
    
//     try {
//       const response = await fetch('/agregar-medicamento', {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json'
//         },
//         body: JSON.stringify(data)
//       });
      
//       if (response.ok) {
//         console.log('Medicamento agregado exitosamente');
//         // Cerrar la ventana modal
//         modalAgregarMedicamento.style.display = 'none';
//         // Actualizar la tabla de medicamentos (puede ser recargando la página o actualizando la tabla con JavaScript)
//       } else {
//         console.error('Error al agregar el medicamento');
//       }
//     } catch (error) {
//       console.error('Error al agregar el medicamento:', error);
//     }
//   });
// });





// function redireccionar() {
//   // Redirige al usuario a la página de destino
//   window.location.href = "admiMenu.html";
//   setTimeout(function() {
//     window.location.href = "pagina_destino.html";
// }, 2000);
// }






 




