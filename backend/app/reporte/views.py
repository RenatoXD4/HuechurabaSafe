from flask import Blueprint, jsonify, request
from extension import db

reporte_bp = Blueprint('reporte', __name__)


@reporte_bp.route('/crearReporte', methods=['POST'])
def crear_reporte():
    from models import Reporte
    data = request.json
    nuevo_reporte = Reporte(
        razon_reporte=data['razon_reporte'],
        id_usuario=data['id_usuario'],
        id_conductor=data['id_conductor']
    )
    db.session.add(nuevo_reporte)
    db.session.commit()
    return jsonify({'mensaje': 'Reporte creado correctamente'}), 201

@reporte_bp.route('/obtenerReporte/<int:id>', methods=['GET'])
def obtener_reporte(id):
    from models import Reporte
    reporte = Reporte.query.get(id)
    if reporte is None:
        return jsonify({'error': 'Reporte no encontrado'}), 404
    reporte_data = {
        'id': reporte.id,
        'razon_reporte': reporte.razon_reporte,
        'id_usuario': reporte.id_usuario,
        'id_conductor': reporte.id_conductor
    }
    return jsonify(reporte_data), 200

@reporte_bp.route('/obtenerReportes', methods=['GET'])
def obtener_todos_los_reportes():
    from models import Reporte
    reportes = Reporte.query.all()
    if not reportes:
        return jsonify({'mensaje': 'No hay reportes disponibles'}), 404

    reportes_data = []
    for reporte in reportes:
        reporte_info = {
            'id': reporte.id,
            'razon_reporte': reporte.razon_reporte,
            'id_usuario': reporte.id_usuario,
            'id_conductor': reporte.id_conductor
        }
        reportes_data.append(reporte_info)

    return jsonify(reportes_data), 200


@reporte_bp.route('/eliminarReporte/<int:id>', methods=['DELETE'])
def eliminar_reporte(id):
    from models import Reporte
    reporte = Reporte.query.get(id)
    if reporte is None:
        return jsonify({'error': 'Reporte no encontrado'}), 404

    db.session.delete(reporte)
    db.session.commit()
    return jsonify({'mensaje': f'Reporte con ID {id} eliminado correctamente'}), 200