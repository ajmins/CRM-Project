from flask import Blueprint, render_template, request
from .models import Category

views = Blueprint('views', __name__)

@views.route('/batches', methods=['GET'])
def batches():
    return render_template('batches.html')

@views.route('/categories')
def categories():
    return render_template('categories.html')
 
@views.route('/qualification')
def qualifications():
    return render_template('qualification.html')