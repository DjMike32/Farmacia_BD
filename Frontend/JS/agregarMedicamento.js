
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
        } else {
          console.error('Error al agregar el medicamento');
        }
      } catch (error) {
        console.error('Error al agregar el medicamento:', error);
      }
    });
  });
  