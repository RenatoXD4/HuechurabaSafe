from flask import Blueprint, jsonify, request
from usuario.models import Usuario
from backend.application import db

usuario_bp = Blueprint('usuario', __name__)


@usuario_bp.route('/usuarios', methods=['POST'])
def crear_usuario():
    data = request.json
    nuevo_usuario = Usuario(username=data['username'], email=data['email'], password=data['password'])
    db.session.add(nuevo_usuario)
    db.session.commit()
    return jsonify({'mensaje': 'Usuario creado correctamente'}), 201

@usuario_bp.route('/usuarios/<int:id>', methods=['GET'])
def obtener_usuario(id):
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404
    usuario_data = {'id': usuario.id, 'usuario': usuario.username, 'email': usuario.email}
    return jsonify(usuario_data), 200

@usuario_bp.route('/usuarios/<int:id>', methods=['PUT'])
def actualizar_usuario(id):
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


@usuario_bp.route('/usuarios/<int:id>', methods=['DELETE'])
def eliminar_usuario(id):
    usuario = Usuario.query.get(id)
    if usuario is None:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    db.session.delete(usuario)
    db.session.commit()
    return jsonify({'mensaje': 'Usuario eliminado correctamente'}), 200