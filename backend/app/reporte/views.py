from flask import Blueprint, jsonify, request
from extension import db
from app.utils.utils import verificar_token

reporte_bp = Blueprint('reporte', __name__)


@reporte_bp.route('/api/crearReporte', methods=['POST'])
@verificar_token
def crear_reporte(id_rol):
    if(id_rol):
        from models import Reporte
        data = request.json
        nuevo_reporte = Reporte(
            razon_reporte=data['razon_reporte'],
            comentarios=data['comentarios'],
            id_usuario=data['id_usuario'],
            id_conductor=data['id_conductor']
        )
        db.session.add(nuevo_reporte)
        db.session.commit()
        return jsonify({'mensaje': 'Reporte creado correctamente'}), 201
    else:
        return jsonify({'mensaje': 'No tienes el permiso para crear un reporte'}), 400
    

@reporte_bp.route('/api/obtenerReporte/<int:id>', methods=['GET'])
@verificar_token
def obtener_reporte(id):
    from models import Reporte
    reporte = Reporte.query.get(id)
    if reporte is None:
        return jsonify({'error': 'Reporte no encontrado'}), 404
    reporte_data = {
        'id': reporte.id,
        'razon_reporte': reporte.razon_reporte,
        'id_usuario': reporte.id_usuario,
        'comentarios': reporte.comentarios,
        'id_conductor': reporte.id_conductor
    }
    return jsonify(reporte_data), 200

@reporte_bp.route('/api/obtenerReportes', methods=['GET'])
@verificar_token
def obtener_todos_los_reportes(id_rol):
    if(id_rol == 2):
        from models import Reporte, Usuario, Conductor, Razon
        reportes = Reporte.query.all()
        if not reportes:
            return jsonify({'mensaje': 'No hay reportes disponibles'}), 404

        reportes_data = []
        for reporte in reportes:
            usuario = Usuario.query.get(reporte.id_usuario)
            conductor = Conductor.query.get(reporte.id_conductor)
            razon_reporte = Razon.query.get(reporte.razon_reporte)
            
            reporte_info = {
                'id': reporte.id,
                'razon_reporte': razon_reporte.razon,
                'nombre_usuario': usuario.username if usuario else 'Desconocido',
                'comentarios': reporte.comentarios,
                'patente_conductor': conductor.patente if conductor else 'Desconocido'
            }
            reportes_data.append(reporte_info)

        return jsonify(reportes_data), 200
    else:
        return jsonify({'error': 'No tienes el permiso para obtener los reportes'})


@reporte_bp.route('/api/eliminarReporte/<int:id>', methods=['DELETE'])
@verificar_token
def eliminar_reporte(id, id_rol):

    if(id_rol):
        from models import Reporte
        reporte = Reporte.query.get(id)
        if reporte is None:
            return jsonify({'error': 'Reporte no encontrado'}), 404

        db.session.delete(reporte)
        db.session.commit()
        return jsonify({'mensaje': f'Reporte con ID {id} eliminado correctamente'}), 200
    else:
        return jsonify({'error': 'No tienes el permiso para borrar este reporte'})