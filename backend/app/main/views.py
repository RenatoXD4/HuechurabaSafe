from flask import Blueprint, jsonify, request
from extension import db

main_bp = Blueprint('main', __name__)


@main_bp.route('/api/crearConductor', methods=['POST'])
def crear_conductor():
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

@main_bp.route('/api/obtenerConductores', methods=['GET'])
def obtener_conductores():
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



@main_bp.route('/api/updateConductor/<int:id>', methods=['PUT'])
def actualizar_conductor(id):
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
def borrarConductor(id):
    from models import Conductor
    conductor = Conductor.query.filter_by(id=id).first()

    if conductor:
        db.session.delete(conductor)
        db.session.commit()
        return jsonify({"message": "Conductor borrado exitosamente"})
    else:
        return jsonify({"message": "Conductor no encontrado"}), 404