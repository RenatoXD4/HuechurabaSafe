from backend.application import db

class Rol(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre_rol = db.Column(db.String(30), unique=True, nullable=False)

    def __repr__(self):
       return f'<Nombre Rol: {self.nombre_rol}>'