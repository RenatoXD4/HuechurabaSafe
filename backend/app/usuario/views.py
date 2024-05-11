from flask import Blueprint, jsonify, request, session
from extension import db
from app.utils.utils import generar_token, verificar_token

usuario_bp = Blueprint('usuario', __name__)

@usuario_bp.route('/api/crearUsuario', methods=['POST'])
def crear_usuario():
    from models import Usuario
    data = request.json
    # Verificar si el correo electrónico ya está registrado
    if Usuario.query.filter_by(email=data['email']).first():
        return jsonify({'error': 'El correo electrónico ya está registrado'}), 400
    # Si el correo electrónico no está registrado, crear un nuevo usuario
    nuevo_usuario = Usuario(username=data['username'], email=data['email'], rol_id=data['rol'])
    hashed_password = nuevo_usuario.hash_password(data['password'])
    nuevo_usuario.password = hashed_password

    db.session.add(nuevo_usuario)
    db.session.commit()
    return jsonify({'mensaje': 'Usuario creado correctamente'}), 201


@usuario_bp.route('/api/usuario/<int:id>', methods=['GET'])
@verificar_token
def obtener_usuario(id):
    from models import Usuario
    from models import Rol
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404
    
    # Obtener el rol del usuario
    rol_usuario = Rol.query.get(usuario.rol_id)
    if rol_usuario is None:
        return jsonify({'error': 'Rol del usuario no encontrado'}), 404
    
    # Crear un diccionario con los datos del usuario y su rol
    usuario_data = {
        'id': usuario.id,
        'username': usuario.username,
        'email': usuario.email,
        'rol': {
            'id': rol_usuario.id,
            'nombre': rol_usuario.nombre_rol
        }
    }
    
    return jsonify(usuario_data), 200

@usuario_bp.route('/api/updateUsuario/<int:id>', methods=['PUT'])
@verificar_token
def actualizar_usuario(id):
    from models import Usuario
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    data = request.json
    if 'username' in data:
        usuario.username = data['username']
    if 'email' in data:
        usuario.email = data['email']
    if 'password' in data:
        usuario.password = data['password']

    db.session.commit()
    return jsonify({'mensaje': 'Usuario actualizado correctamente'}), 200


@usuario_bp.route('/api/deleteUsuario/<int:id>', methods=['DELETE'])
@verificar_token
def eliminar_usuario(id):
    from models import Usuario
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    db.session.delete(usuario)
    db.session.commit()
    return jsonify({'mensaje': 'Usuario eliminado correctamente'}), 200


@usuario_bp.route('/api/usuario', methods=['GET'])
@verificar_token
def obtener_usuario_autenticado(usuario_id):
    from models import Usuario
    usuario = Usuario.query.get(usuario_id)
    if usuario:
        return jsonify({
            'id': usuario.id,
            'username': usuario.username,
            'email': usuario.email,
            'rol_id': usuario.rol_id 
        }), 200
    else:
        return jsonify({'error': 'Usuario no encontrado'}), 404




# Ruta para iniciar sesión
@usuario_bp.route('/api/login', methods=['POST'])
def login():
    from models import Usuario
    email = request.json.get('email')
    passwordp = request.json.get('password')

    usuario = Usuario.query.filter_by(email=email).first()

    if usuario and usuario.verificar_password(passwordp):
        # Generar un token JWT
        token = generar_token(usuario.id)
        
        # Devolver el token como respuesta exitosa
        return jsonify({'token': token}), 200
    else:
        return jsonify({'error': 'Nombre de usuario o contraseña incorrectos'}), 401

@usuario_bp.route('/api/logout')
def logout():

    return jsonify({'mensaje': 'Sesión cerrada correctamente'}), 200