from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)

# Importa y registra tus blueprints aquí
from app.main.views import main_bp
app.register_blueprint(main_bp)

if __name__ == "__main__":
    app.run(debug=True)