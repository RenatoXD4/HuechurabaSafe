from flask import Blueprint, jsonify, request
from extension import db
from app.utils.utils import verificar_token

main_bp = Blueprint('main', __name__)


@main_bp.route('/api/crearConductor', methods=['POST'])
@verificar_token
def crear_conductor(id_rol=None):
    if(id_rol == 2):
        from models import Conductor

        # Acceder a los campos del formulario
        nombre = request.form.get('nombre')
        patente = request.form.get('patente')
        auto = request.form.get('auto')

        # Verificar si la patente ya está en uso
        if Conductor.query.filter_by(patente=patente).first():
            return jsonify({'error': 'La patente ya está registrada'}), 400

        # Crear un nuevo conductor si la patente no está en uso
        nuevo_conductor = Conductor(nombre_conductor=nombre,patente=patente, nombre_vehiculo=auto)
        db.session.add(nuevo_conductor)
        db.session.commit()

        # Guardar la foto del conductor si se adjuntó
        foto_conductor = request.files.get('foto')
        if foto_conductor:
            nuevo_conductor.save_foto(foto_conductor)

        return jsonify({'mensaje': 'Conductor creado correctamente'}), 201
    else:
        return jsonify({'mensaje': 'No tienes el permiso para crear un conductor'}), 400

@main_bp.route('/api/obtenerConductores', methods=['GET'])
@verificar_token
def obtener_conductores(id_rol=None):
    if(id_rol == 2):
        from models import Conductor
        conductores = Conductor.query.all()
        conductores_data = []
        for conductor in conductores:
            foto_url = request.url_root + conductor.foto if conductor.foto else None
            conductor_data = {
                'id': conductor.id,
                'nombre': conductor.nombre_conductor,
                'patente': conductor.patente,
                'auto': conductor.nombre_vehiculo,
                'foto': foto_url
            }
            conductores_data.append(conductor_data)
        return jsonify({'conductor': conductores_data})
    else:
        return jsonify({'error': 'No tienes el permiso para obtener los conductores'})



@main_bp.route('/api/updateConductor/<int:id>', methods=['PUT'])
@verificar_token
def actualizar_conductor(id, id_rol=None):

    if(id_rol == 2):
        from models import Conductor
        conductor = Conductor.query.get(id)
        if conductor is None:
            return jsonify({'error': 'Conductor no encontrado'}), 404

        # Obtener los datos del formulario
        nombre = request.form.get('nombre')
        patente = request.form.get('patente')
        auto = request.form.get('auto')
        nueva_foto = request.files.get('foto')

        # Actualizar la foto si se proporciona una nueva
        if nueva_foto:
            conductor.save_foto(nueva_foto)

        # Actualizar los otros campos si se proporcionan
        if nombre:
            conductor.nombre_conductor = nombre
        if patente:
            conductor.patente = patente
        if auto:
            conductor.nombre_vehiculo = auto

        db.session.commit()

        return jsonify({'message': 'Conductor actualizado correctamente'}), 200
    else:
        
        return jsonify({'message': 'No tienes el permiso para actualizar el conductor'}), 400


@main_bp.route('/api/obtenerConductor/<string:patente>', methods=['GET'])
def obtenerConductor(patente):
    from models import Conductor

    conductor = Conductor.query.filter_by(patente=patente).first()

    if conductor:
        # Obtener la URL completa de la foto del conductor
        foto_url = request.url_root + conductor.foto if conductor.foto else None

        return jsonify({
            'id': conductor.id,
            'nombre': conductor.nombre_conductor,
            'patente': conductor.patente,
            'auto': conductor.nombre_vehiculo,
            'foto': foto_url
        })
    else:
        return jsonify({'mensaje': 'Conductor no encontrado'}), 404
    

@main_bp.route('/api/borrarConductor/<int:id>', methods=['DELETE'])
@verificar_token
def borrarConductor(id, id_rol=None):
    if(id_rol == 2):

        from models import Conductor
        conductor = Conductor.query.filter_by(id=id).first()

        if conductor:
            db.session.delete(conductor)
            db.session.commit()
            return jsonify({"message": "Conductor borrado exitosamente"})
        else:
            return jsonify({"message": "Conductor no encontrado"}), 404
    else:
       return jsonify({"message": "No tienes el permiso para actualizar un conductor"}), 400