from backend.application import db

class Conductor(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    nombre_conductor = db.Column(db.String(80), nullable=False)
    patente = db.Column(db.String(80), unique=True, nullable=False)
    nombre_vehiculo = db.Column(db.String(80), nullable=False)

    def __repr__(self):
        return f'<Conductor {self.nombre_conductor}>'