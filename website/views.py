from flask import Blueprint, render_template

views = Blueprint('views', __name__)

@views.route('/batches')
def batches():
    return render_template('batches.html')