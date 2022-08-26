from flask import Blueprint, render_template

views = Blueprint('views', __name__)

@views.route('/batches')
def batches():
    return render_template('batches.html')

@views.route('/categories')
def categories():
    return render_template('categories.html')
 
@views.route('/qualification')
def qualifications():
    return render_template('qualification.html')