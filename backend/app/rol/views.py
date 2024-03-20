from flask import Blueprint, jsonify, request
from rol.models import Rol
from backend.application import db


rol_bp = Blueprint('rol', __name__)


@rol_bp.route('/obtenerRoles', methods=['GET'])
def obtener_roles():
    roles = Rol.query.all()
    roles_json = [{'id': rol.id, 'nombre_rol': rol.nombre_rol} for rol in roles]
    return jsonify({'roles': roles_json})

@rol_bp.route('/crearRol', methods=['POST'])
def crear_rol():
    data = request.json
    nuevo_rol = Rol(nombre_rol=data['nombre_rol'])
    db.session.add(nuevo_rol)
    db.session.commit()
    return jsonify({'mensaje': 'Rol creado correctamente'}), 201
     