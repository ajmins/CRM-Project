from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from os import path

db = SQLAlchemy() 
#DB_NAME = "database.db"
DB_NAME = "chummaveruthe"
# SQL_SERVER_USER_PASS_IP_PORT = 'sa:123@192.168.5.74:1891'
SQL_SERVER_USER_PASS_IP_PORT = 'DESKTOP-5AA8MOJ\MSSQLSERVER01'

def create_app():
    app = Flask(__name__)
    # encrypts the cookie data

    # app.config['SQLALCHEMY_DATABASE_URI'] = r'mssql+pyodbc://sa:123@192.168.5.152:1891/chummaveruthe?driver=SQL+Server+Native+Client+11.0'.format(SQL_SERVER_USER_PASS_IP_PORT, DB_NAME)
    
    app.config['SQLALCHEMY_DATABASE_URI'] = r'mssql+pyodbc://{}/{}?driver=SQL+Server+Native+Client+11.0'.format(SQL_SERVER_USER_PASS_IP_PORT, DB_NAME)

    print("server connected!")
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = "123"
    db.init_app(app)

    from .views import views
    # from .auth import auth

    app.register_blueprint(views, url_prefix='/')
    # app.register_blueprint(auth, url_prefix='/')

    create_database(app)

    return app


def create_database(app):
    db.create_all(app=app)
    print('Created Database!')