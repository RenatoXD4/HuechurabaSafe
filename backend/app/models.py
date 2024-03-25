import os
from flask import url_for
from application import db


class Usuario(db.Model):
    from application import db
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)
    rol_id = db.Column(db.Integer, db.ForeignKey('rol.id'), nullable=False)

    def __repr__(self):
       return f'<Usuario: {self.username}>'
    

class Rol(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre_rol = db.Column(db.String(30), unique=True, nullable=False)

    def __repr__(self):
       return f'<Nombre Rol: {self.nombre_rol}>'

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