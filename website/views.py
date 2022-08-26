from flask import Blueprint, render_template, request
from .models import Category

views = Blueprint('views', __name__)

@views.route('/batches', methods=['GET'])
def batches():
    categories = Category.query.all()
    return render_template('batches.html', categories=categories)