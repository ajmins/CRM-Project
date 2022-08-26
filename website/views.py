from flask import Blueprint, render_template, request
from .models import Category, Qualifications

views = Blueprint('views', __name__)

@views.route('/batches', methods=['GET'])
def batches():
    return render_template('batches.html')

@views.route('/categories')
def categories():
    categories=Category.query.all()
    return render_template('categories.html',categories=categories)
 
@views.route('/qualification')
def qualifications():
    qualifications=Qualifications.query.all()
    return render_template('qualification.html',qualifications=qualifications)