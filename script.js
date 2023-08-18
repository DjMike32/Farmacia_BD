document.addEventListener('DOMContentLoaded', function() {
    const consultButton = document.getElementById('consultButton');
    const resultDiv = document.getElementById('result');
    
    consultButton.addEventListener('click', async function() {
        try {
            const response = await fetch('/api/consultar-Pais'); // Cambia la ruta si es necesario
            const data = await response.json();
            
            if (data && data.length > 0) {
                resultDiv.innerHTML = '<h2>Resultados de la consulta:</h2>';
                data.forEach(row => {
                    resultDiv.innerHTML += `<p>ID: ${row.ID_Pais}, Descripción: ${row.Descripcion}</p>`;
                });
            } else {
                resultDiv.innerHTML = '<p>No se encontraron resultados.</p>';
            }
        } catch (error) {
            console.error('Error al realizar la consulta:', error);
            resultDiv.innerHTML = '<p>Error al realizar la consulta.</p>';
        }
    });
});


