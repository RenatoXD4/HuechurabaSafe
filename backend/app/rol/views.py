from flask import Blueprint, jsonify, request
from extension import db


rol_bp = Blueprint('rol', __name__)


@rol_bp.route('/api/obtenerRoles', methods=['GET'])
def obtener_roles():
    from models import Rol
    roles = Rol.query.all()
    roles_json = [{'id': rol.id, 'nombre_rol': rol.nombre_rol} for rol in roles]
    return jsonify({'roles': roles_json})

@rol_bp.route('/api/crearRol', methods=['POST'])
def crear_rol():
    from models import Rol
    data = request.json
    nuevo_rol = Rol(nombre_rol=data['nombre_rol'])
    db.session.add(nuevo_rol)
    db.session.commit()
    return jsonify({'mensaje': 'Rol creado correctamente'}), 201
     