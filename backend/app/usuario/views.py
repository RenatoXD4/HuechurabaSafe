from flask import Blueprint, jsonify, request, session
from extension import db

usuario_bp = Blueprint('usuario', __name__)


@usuario_bp.route('/api/crearUsuario', methods=['POST'])
def crear_usuario():
    from models import Usuario
    data = request.json
    nuevo_usuario = Usuario(username=data['username'], email=data['email'], rol_id=data['rol'])
    # Hashear la contraseña antes de almacenarla en la base de datos
    hashed_password = nuevo_usuario.hash_password(data['password'])
    nuevo_usuario.password = hashed_password

    db.session.add(nuevo_usuario)
    db.session.commit()
    return jsonify({'mensaje': 'Usuario creado correctamente'}), 201

@usuario_bp.route('/api/usuario/<int:id>', methods=['GET'])
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
        'usuario': usuario.username,
        'email': usuario.email,
        'rol': {
            'id': rol_usuario.id,
            'nombre': rol_usuario.nombre_rol
        }
    }
    
    return jsonify(usuario_data), 200

@usuario_bp.route('/api/updateUsuario/<int:id>', methods=['PUT'])
def actualizar_usuario(id):
    from models import Usuario
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    data = request.json
    if 'username' in data:
        usuario.username = data['usuario']
    if 'email' in data:
        usuario.email = data['email']
    if 'password' in data:
        usuario.password = data['password']

    db.session.commit()
    return jsonify({'mensaje': 'Usuario actualizado correctamente'}), 200


@usuario_bp.route('/api/deleteUsuario/<int:id>', methods=['DELETE'])
def eliminar_usuario(id):
    from models import Usuario
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    db.session.delete(usuario)
    db.session.commit()
    return jsonify({'mensaje': 'Usuario eliminado correctamente'}), 200



# Ruta para iniciar sesión
@usuario_bp.route('/api/login', methods=['POST'])
def login():
    from models import Usuario
    username = request.json.get('username')
    password = request.json.get('password')

    usuario = Usuario.query.filter_by(username=username).first()

    if usuario and Usuario.verificar_password(usuario.password, password):
        session['user_id'] = usuario.id
        return jsonify({'mensaje': 'Inicio de sesión exitoso'}), 200
    else:
        return jsonify({'error': 'Nombre de usuario o contraseña incorrectos'}), 401

# Ruta para cerrar sesión
@usuario_bp.route('/api/logout')
def logout():
    # Eliminar el ID del usuario de la sesión
    session.pop('user_id', None)
    return jsonify({'mensaje': 'Sesión cerrada correctamente'}), 200