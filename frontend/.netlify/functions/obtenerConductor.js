import fetch from 'node-fetch';

exports.handler = async (event, context) => {
  const apiIp = process.env.API_IP;
  const { patente } = event.queryStringParameters;

  if (!patente) {
    return {
      statusCode: 400,
      headers: {
        'Access-Control-Allow-Origin': '*',
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
          'Access-Control-Allow-Origin': '*',
        },
        body: JSON.stringify(jsonData),
      };
    } else {
      return {
        statusCode: response.status,
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
        body: JSON.stringify({ error: 'Hubo un error al obtener el conductor.' }),
      };
    }
  } catch (error) {
    return {
      statusCode: 500,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify({ error: `Hubo un error al obtener el conductor: ${error.message}` }),
    };
  }
};