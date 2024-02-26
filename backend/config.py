class Config:
    # Configuración secreta (asegúrate de cambiarlo en producción)
    SECRET_KEY = 'tu_clave_secreta'

    # Configuración de la base de datos MariaDB
    MYSQL_HOST = 'localhost'
    MYSQL_USER = 'tu_usuario'
    MYSQL_PASSWORD = 'tu_contraseña'
    MYSQL_DB = 'nombre_de_tu_base_de_datos'
    MYSQL_PORT = 3306  # Puerto predeterminado para MariaDB

    # Otras configuraciones
    DEBUG = True
    TESTING = False