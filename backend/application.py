from flask import Flask
from flask_migrate import Migrate
from config import Config
from extension import db
from app.main.views import main_bp
from app.usuario.views import usuario_bp
from app.rol.views import rol_bp

app = Flask(__name__)
app.config.from_object(Config)

db.init_app(app)
migrate = Migrate(app, db)

app.register_blueprint(main_bp)

app.register_blueprint(usuario_bp)

app.register_blueprint(rol_bp)


if __name__ == "__main__":
    app.run(debug=True)