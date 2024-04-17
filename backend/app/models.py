import os
from flask import url_for
from application import db
import bcrypt


class Usuario(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    username = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)
    rol_id = db.Column(db.Integer, db.ForeignKey('rol.id'))
    usuarios = db.relationship('Reporte', backref="usuario")

    def __repr__(self):
       return f'<Usuario: {self.username}>'
    def hash_password(self, password):
        # Generar un salt aleatorio
        salt = bcrypt.gensalt()
        # Hashear la contraseña utilizando el salt
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
        return hashed_password

    # Otro método para verificar la contraseña
    def verificar_password(self, password_ingresada):
        # Verificar la contraseña ingresada con la contraseña hasheada
        return bcrypt.checkpw(password_ingresada.encode('utf-8'), self.password.encode('utf-8'))
    

class Rol(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    nombre_rol = db.Column(db.String(30), unique=True, nullable=False)
    users = db.relationship('Usuario', backref='rol')

    def __repr__(self):
       return f'<Nombre Rol: {self.nombre_rol}>'

class Conductor(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    nombre_conductor = db.Column(db.String(80), nullable=False)
    patente = db.Column(db.String(80), unique=True, nullable=False, index=True)
    nombre_vehiculo = db.Column(db.String(80), nullable=False)
    foto_path = db.Column(db.String(255)) 
    conductores = db.relationship('Reporte', backref="conductor")

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
    
class Reporte(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    razon_reporte = db.Column(db.Integer, db.ForeignKey('razon.id'), nullable=False)
    comentarios = db.Column(db.String(500), nullable=True)
    id_usuario = db.Column(db.Integer, db.ForeignKey('usuario.id'), nullable=False)
    id_conductor = db.Column(db.Integer, db.ForeignKey('conductor.id'), nullable=False)

    def __repr__(self):
        return f'<Reporte: {self.id}>'

class Razon(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    razon = db.Column(db.String(80), nullable=False)
    razones = db.relationship('Reporte', backref="razon")

    def __repr__(self):
        return f'<Reporte: {self.id}>'