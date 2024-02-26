from flask import Flask
from flask_mysqldb import MySQL  # Importa MySQL desde flask_mysql
from config import Config

def create_app():
    app = Flask(__name__)

    # Configuración de la aplicación
    app.config.from_object(Config)

    # Configuración de MySQL con Flask-MySQLdb
    mysql = MySQL(app)

    # Importa y registra tus blueprints aquí
    from main.views import main_bp
    app.register_blueprint(main_bp)

    return app

if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)