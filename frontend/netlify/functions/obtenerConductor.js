import fetch from 'node-fetch';

export async function handler(event, context) {
  const apiIp = process.env.API_IP;
  const token = event.headers['authorization'];

  if (!token) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: 'No se proporcionó un token de autenticación.' }),
    };
  }

  try {
    const response = await fetch(`http://${apiIp}:9090/api/obtenerConductores`, {
      method: 'GET',
      headers: { 'Authorization': token },
    });

    if (response.statusCode === 200) {
      const jsonData = await response.json();

      if (jsonData.conductor) {
        return {
          statusCode: 200,
          body: JSON.stringify(jsonData.conductor),
        };
      } else {
        return {
          statusCode: 400,
          body: JSON.stringify({ error: 'El JSON no contiene la clave "conductor" o no es un mapa válido.' }),
        };
      }
    } else {
      return {
        statusCode: response.status,
        body: JSON.stringify({ error: 'Hubo un error al obtener los conductores.' }),
      };
    }
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: `Hubo un error al obtener los conductores: ${error.message}` }),
    };
  }
}