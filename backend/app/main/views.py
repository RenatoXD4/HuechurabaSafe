from flask import Blueprint, jsonify, request
from main.models import Conductor
from backend.application import db

main_bp = Blueprint('main', __name__)

def crear_conductor():
    data = request.json
    nuevo_conductor = Conductor(patente=data['patente'], nombre=data['nombre'], auto=data['auto'])
    db.session.add(nuevo_conductor)
    db.session.commit()

    foto_conductor = request.files.get('foto')
    if foto_conductor:
        nuevo_conductor.save_foto(foto_conductor)

    return jsonify({'mensaje': 'Conductor creado correctamente'}), 201

@main_bp.route('/conductores', methods = ['GET'])
def obtener_conductores():
    conductores = Conductor.query.all()
    conductores_data = []
    for conductor in conductores:
        conductor_data = {
            'id': conductor.id,
            'nombre_conductor': conductor.nombre_conductor,
            'patente': conductor.patente,
            'nombre_vehiculo': conductor.nombre_vehiculo,
            'foto_url': conductor.obtener_foto_url()
        }
        conductores_data.append(conductor_data)
    return jsonify(conductores_data)


@main_bp.route('/conductores/<int:id>', methods=['PUT'])
def actualizar_conductor(id):
    conductor = Conductor.query.get(id)
    if conductor is None:
        return jsonify({'error': 'Conductor no encontrado'}), 404

    data = request.get_json()
    if 'nombre_conductor' in data:
        conductor.nombre_conductor = data['nombre_conductor']
    if 'patente' in data:
        conductor.patente = data['patente']
    if 'nombre_vehiculo' in data:
        conductor.nombre_vehiculo = data['nombre_vehiculo']
    if 'foto_path' in data:
        conductor.foto_path = data['foto_path']

    db.session.commit()

    return jsonify({'message': 'Conductor actualizado correctamente'}), 200


@main_bp.route('/conductor/<str:patente>', methods = ['GET'])
def obtenerConductor(patente):
    patente = any

    conductor = Conductor.query.filter_by(patente=patente).first()

    if conductor:
        return jsonify({'conductor': {
            'nombre': conductor.nombre,
            'patente': conductor.patente,
            'auto': conductor.auto,
        }})
    else:
        return jsonify({'mensaje': 'Conductor no encontrado'}), 404
    

@main_bp.route('/borrar/<str:patente>', methods=['DELETE'])
def borrarConductor(patente):
    conductor = Conductor.query.filter_by(patente=patente).first()

    if conductor:
        db.session.delete(conductor)
        db.session.commit()
        return jsonify({"message": "Conductor deleted successfully"})
    else:
        return jsonify({"message": "Conductor not found"}), 404