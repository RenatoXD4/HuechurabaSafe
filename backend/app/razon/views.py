from flask import Blueprint, jsonify, request, session
from extension import db

razon_bp = Blueprint('razon', __name__)

@razon_bp.route('/razones', methods=['GET'])
def obtener_razones():
    from models import Razon
    razones = Razon.query.all()
    return jsonify([razon.serialize() for razon in razones])