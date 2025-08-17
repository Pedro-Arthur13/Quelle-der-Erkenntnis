from flask import Flask
import os

def create_app():
    app = Flask(__name__)
    
    app.config['SECRET_KEY'] = 'aa'
    app.config['DATABASE'] = os.path.join(app.instance_path, 'biblioteca.sqlite')

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from . import database
    database.init_app(app)

    from . import routes
    app.register_blueprint(routes.bp)

    return app