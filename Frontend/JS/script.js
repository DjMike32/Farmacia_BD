// document.addEventListener('DOMContentLoaded', () => {
//     // Función para buscar y mostrar información del cliente
//     const searchAndShowClienteInfo = () => {
//         // Código para buscar y mostrar información del cliente aquí
//     };

//     // Función para agregar un nuevo cliente
//     const addCliente = () => {
//         // Código para agregar un nuevo cliente aquí
//     };

//     // Función para actualizar información de cliente
//     const updateClienteInfo = () => {
//         // Código para actualizar información de cliente aquí
//     };

//     // Función para eliminar un cliente
//     const deleteCliente = () => {
//         // Código para eliminar un cliente aquí
//     };

//     // Asignar eventos a los botones
//     const listButton = document.querySelector('#listButton');
//     const addButton = document.querySelector('#addButton');
//     const editButton = document.querySelector('#editButton');
//     const deleteButton = document.querySelector('#deleteButton');

//     listButton.addEventListener('click', searchAndShowClienteInfo);
//     addButton.addEventListener('click', addCliente);
//     editButton.addEventListener('click', updateClienteInfo);
//     deleteButton.addEventListener('click', deleteCliente);
// });




// document.addEventListener('DOMContentLoaded', async () => {
//     try {
//       const response = await fetch('/consultar-Medicamento'); // Cambia la URL según tu configuración
//       const data = await response.json();
      
//       const tableBody = document.getElementById('medicamentosTableBody');
      
//       data.forEach(medicamento => {
//         const row = document.createElement('tr');
        
//         const idCell = document.createElement('td');
//         idCell.textContent = medicamento.ID_Medicamentos;
//         row.appendChild(idCell);
        
//         const nombreCell = document.createElement('td');
//         nombreCell.textContent = medicamento.Nombre; // Cambia el nombre de la columna según tu tabla
//         row.appendChild(nombreCell);
        
//         // Agrega más celdas para otras columnas
        
//         tableBody.appendChild(row);
//       });
//     } catch (error) {
//       console.error('Error al obtener los datos:', error);
//     }
//   });



  
  