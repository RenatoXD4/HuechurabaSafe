class Config:
    SECRET_KEY = 'tu_clave_secreta'
    SQLALCHEMY_DATABASE_URI = 'mariadb://tu_usuario:tu_contraseña@localhost/tu_base_de_datos'
    SQLALCHEMY_TRACK_MODIFICATIONS = False