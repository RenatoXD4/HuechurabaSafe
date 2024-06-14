import fetch from 'node-fetch';

exports.handler = async (event, context) => {
    const apiIp = process.env.API_IP;
    const { patente } = event.queryStringParameters;
  
    if (!patente) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: 'No se proporcionó la patente.' }),
      };
    }
  
    try {
      const response = await fetch(`http://${apiIp}:9090/api/obtenerConductor/${patente}`, {
        method: 'GET',
      });
  
      if (response.status === 200) {
        const jsonData = await response.json();
        return {
          statusCode: 200,
          body: JSON.stringify(jsonData),
        };
      } else {
        return {
          statusCode: response.status,
          body: JSON.stringify({ error: 'Hubo un error al obtener el conductor.' }),
        };
      }
    } catch (error) {
      return {
        statusCode: 500,
        body: JSON.stringify({ error: `Hubo un error al obtener el conductor: ${error.message}` }),
      };
    }
  };