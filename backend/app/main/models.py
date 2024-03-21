import os
from flask import url_for
from backend.application import db

class Conductor(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    nombre_conductor = db.Column(db.String(80), nullable=False)
    patente = db.Column(db.String(80), unique=True, nullable=False)
    nombre_vehiculo = db.Column(db.String(80), nullable=False)
    foto_path = db.Column(db.String(255)) 

    def __repr__(self):
        return f'<Conductor: {self.nombre_conductor}>'

    def save_foto(self, foto_data):
        if foto_data:
            filename = f"{self.id}_foto.jpg"
            foto_path = os.path.join('static', 'img', filename) 
            foto_data.save(foto_path)
            self.foto_path = url_for('static', filename=f'img/{filename}')
            db.session.commit()

    def obtener_foto_url(self):
        return url_for('static', filename=self.foto_path)