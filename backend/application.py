from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)

# Importa y registra tus blueprints aquí
from app.main.views import main_bp
app.register_blueprint(main_bp)

from app.usuario.views import usuario_bp
app.register_blueprint(usuario_bp)


from app.rol.views import rol_bp
app.register_blueprint(rol_bp)

db.init_app(app)

if __name__ == "__main__":
    app.run(debug=True)