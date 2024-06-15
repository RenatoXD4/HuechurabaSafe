import fetch from 'node-fetch';

const handler = async (event) => {
  const apiIp = process.env.API_IP;
  const { patente } = event.queryStringParameters;

  if (!patente) {
    return {
      statusCode: 400,
      headers: {
        'Access-Control-Allow-Origin': '*',  // O ajusta esto según tu necesidad
        'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
      },
      body: JSON.stringify({ error: 'No se proporcionó la patente.' }),
    };
  }

  try {
    const response = await fetch(`http://${apiIp}:9090/api/obtenerConductor/${patente}`);

    if (response.status === 200) {
      const jsonData = await response.json();
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',  // O ajusta esto según tu necesidad
          'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
        },
        body: JSON.stringify(jsonData),
      };
    } else {
      return {
        statusCode: response.status,
        headers: {
          'Access-Control-Allow-Origin': '*',  // O ajusta esto según tu necesidad
          'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
        },
        body: JSON.stringify({ error: 'Hubo un error al obtener el conductor.' }),
      };
    }
  } catch (error) {
    return {
      statusCode: 500,
      headers: {
        'Access-Control-Allow-Origin': '*',  // O ajusta esto según tu necesidad
        'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
      },
      body: JSON.stringify({ error: `Hubo un error al obtener el conductor: ${error.message}` }),
    };
  }
};

export { handler };