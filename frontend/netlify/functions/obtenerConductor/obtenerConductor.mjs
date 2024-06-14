// Docs on event and context https://docs.netlify.com/functions/build/#code-your-function-2
const handler = async (event) => {
  try {
    const apiIp = process.env.API_IP;
    const { patente } = event.queryStringParameters;
    const headers = {
      'Access-Control-Allow-Origin': 'https://666cd6883d4ad0330faa68ba--astounding-sprinkles-f47c1e.netlify.app',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
    };

    if (!patente) {
      return {
        statusCode: 400,
        headers: headers,
        body: JSON.stringify({ error: 'No se proporcionó la patente.' }),
      };
    }

    try {
      const response = await fetch(`http://${apiIp}:9090/api/obtenerConductor/${patente}`);

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

  } catch (error) {
    return {
      statusCode: 500,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify({ error: `Hubo un error: ${error.message}` }),
    };
  }
};

export default { handler };
