import os


class Config:
    SECRET_KEY = '4e908bbd06d8918afef7c1d6c1a4ef56'
    SQLALCHEMY_DATABASE_URI = 'mysql://prueba1:admin@0.0.0.0/prueba'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024