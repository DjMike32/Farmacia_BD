function validarFormulario() {
    // Obtener referencias a los campos del formulario
    var nombreMedicamento = document.getElementById('nombre_medicamento').value;
    var noLote = document.getElementById('no_lote').value;
    var idProducto = document.getElementById('id_producto_tm').value;
    var idTipoMedicamento = document.getElementById('id_tipo_medicamento').value;
    var img = document.getElementById('img').value;
    var precio = document.getElementById('precio').value;
    var existencias = document.getElementById('existencias').value;
    var fechaVencimiento = document.getElementById('fecha_vencimiento').value;
    var fechaElaboracion = document.getElementById('fecha_laboracion').value;

    // Verificar si algún campo requerido está vacío
    if (
      nombreMedicamento === '' ||
      noLote === '' ||
      idProducto === '' ||
      idTipoMedicamento === '' ||
      img === '' ||
      precio === '' ||
      existencias === '' ||
      fechaVencimiento === '' ||
      fechaElaboracion === ''
    ) {
      // Campos vacíos, no hacer nada
      return;
    }

    // Mostrar ventana emergente si los campos están completos
    alert('Medicamento agregado correctamente');
  }




document.addEventListener('DOMContentLoaded', () => {
    const agregarMedicamentoForm = document.getElementById('agregarMedicamentoForm');
  
    agregarMedicamentoForm.addEventListener('submit', async (event) => {
      event.preventDefault();
  
      const formData = new FormData(agregarMedicamentoForm);
      const jsonData = {};
  
      for (const [key, value] of formData.entries()) {
        jsonData[key] = value;
      }
  
      console.log('Datos enviados:', jsonData); // Muestra los datos en la consola
  
      try {
        const response = await fetch('/agregar-medicamento', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(jsonData)
        });
  
        if (response.ok) {
          console.log('Medicamento agregado exitosamente');
        } 
      } catch (jsonData) {
        console.error('Error al agregar el medicamento:');
      }
    });
  });
  