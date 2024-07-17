import fetch from 'node-fetch';

const handler = async (event) => {
  const apiIp = process.env.API_IP;
  const { username, email, password, rol } = JSON.parse(event.body);

  const headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*', // Ajusta según tus necesidades de CORS
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
    'Access-Control-Allow-Methods': 'POST',
  };

  try {
    const response = await fetch(`http://${apiIp}:9090/api/crearUsuario`, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({ username, email, password, rol }),
    });

    console.log(username, email, password, rol)

    if (!response.ok) {
      if (response.status === 400) {
        const errorData = await response.json();
        return {
          statusCode: 400,
          headers: headers,
          body: JSON.stringify({ error: errorData.error }),
        };
      }
      throw new Error('Hubo un problema al crear el usuario');
    }

    const jsonData = await response.json();
    return {
      statusCode: 200,
      headers: headers,
      body: JSON.stringify(jsonData),
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers: headers,
      body: JSON.stringify({ error: `Error del servidor: ${error.message}` }),
    };
  }
};

export { handler };