import datetime
from functools import wraps
import inspect
from flask import jsonify, request
import jwt

SECRET_KEY = 'tu_clave_secreta'

def generar_token(usuario_id, id_rol):
    expiracion = datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(hours=4)
    expiracion_unix_timestamp = expiracion.timestamp()  # Convertir a UNIX timestamp

    payload = {
        'usuario_id': usuario_id,
        'rol_id': id_rol,
        'exp': expiracion_unix_timestamp  # Usar el timestamp como valor de expiración
    }

    token = jwt.encode(payload, SECRET_KEY, algorithm='HS256')
    
    return token

def verificar_token(func):
    @wraps(func)
    def verificar_token_wrapper(*args, **kwargs):
        token = request.headers.get('Authorization')

        if not token:
            return jsonify({'error': 'Token no proporcionado'}), 401

        if token.startswith("Bearer "):
            token = token[len("Bearer "):]
        

        try:
           payload = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
           rol_id = payload.get('rol_id')

           func_signature = inspect.signature(func)
           if 'rol_id' in func_signature.parameters:
                kwargs['rol_id'] = rol_id
           
        except jwt.ExpiredSignatureError:
            return jsonify({'error': 'Token expirado'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'error': 'Token inválido'}), 401

        return func(*args, **kwargs)

    return verificar_token_wrapper