from flask import Flask
from flask_migrate import Migrate
from config import Config
from extension import db
from app.main.views import main_bp
from app.usuario.views import usuario_bp
from app.rol.views import rol_bp
from app.reporte.views import reporte_bp
from app.razon.views import razon_bp
from flask_cors import CORS



from models import Usuario, Rol, Conductor, Reporte, Razon

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "https://6678e0f5d230f515ae00e5da--astounding-sprinkles-f47c1e.netlify.app"}})
app.config.from_object(Config)


app.register_blueprint(main_bp)

app.register_blueprint(usuario_bp)

app.register_blueprint(rol_bp)

app.register_blueprint(reporte_bp)

app.register_blueprint(razon_bp)

db.init_app(app)
migrate = Migrate(app, db)

with app.app_context():
    if not Rol.query.filter_by(nombre_rol='Usuario').first():
        rol_usuario = Rol(nombre_rol='Usuario')
        db.session.add(rol_usuario)

    if not Rol.query.filter_by(nombre_rol='Administrador').first():
        rol_administrador = Rol(nombre_rol='Administrador')
        db.session.add(rol_administrador)

    razones = [
        'Alargar trayecto a propósito',
        'Conducción peligrosa',
        'Exceso de velocidad',
        'Otro'
    ]

    for razon in razones:
        if not Razon.query.filter_by(razon=razon).first():
            nueva_razon = Razon(razon=razon)
            db.session.add(nueva_razon)

    db.session.commit()

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=9090)