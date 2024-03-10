from flask import Blueprint, jsonify, request
from main.models import Conductor
from backend.application import db

main_bp = Blueprint('main', __name__)

@main_bp.route('/crearConductor', methods = ['POST'])
def crearConductor():
    conductor = None

    if request.form:
        patente_conductor = request.form.get('patente')
        nombre_conductor = request.form.get('nombre')
        nombre_auto = request.form.get('auto')
        foto_conductor = request.form.get('foto')
        conductor = {
            'patente': patente_conductor,
            'nombre': nombre_conductor,
            'auto': nombre_auto,
            'foto': foto_conductor
        }
        db.session.add(conductor)
        db.session.commit()
    # Devuelve los datos como respuesta JSON
    return jsonify({'conductor': conductor})


@main_bp.route('/conductor/<patente>', methods = ['GET'])
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
    

@main_bp.route('/borrar/<patente>', methods=['DELETE'])
def borrarConductor(patente):
    conductor = Conductor.query.filter_by(patente=patente).first()

    if conductor:
        db.session.delete(conductor)
        db.session.commit()
        return jsonify({"message": "Conductor deleted successfully"})
    else:
        return jsonify({"message": "Conductor not found"}), 404