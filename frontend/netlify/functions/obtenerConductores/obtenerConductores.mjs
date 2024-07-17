import fetch from 'node-fetch';

const handler = async (event) => {
  const apiIp = process.env.API_IP;
  const {token} = event.headers

  try {
    const response = await fetch(`http://${apiIp}:9090/api/obtenerConductores`, {
      headers: {
        'Authorization': `Bearer ${token}`,
      },
    });

    const headers = {
      'Access-Control-Allow-Origin': '*',  // Ajusta esto según sea necesario
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization',
      'Access-Control-Allow-Methods': 'GET',
    };

    if (response.status === 200) {
      const jsonData = await response.json();
      return {
        statusCode: 200,
        headers: headers,
        body: JSON.stringify(jsonData),
      };
    } else {
      return {
        statusCode: response.status,
        headers: headers,
        body: JSON.stringify({ error: 'Hubo un error al obtener los conductores' }),
      };
    }
  } catch (error) {
    return {
      statusCode: 500,
      headers: headers,
      body: JSON.stringify({ error: `Hubo un error al obtener los conductores ${error.message}` }),
    };
  }
};

export { handler };