from flask import Blueprint, render_template, request, jsonify, url_for, redirect
from . import db
from .models import Category, Qualifications
import json

views = Blueprint('views', __name__)

#categories =[]

@views.route('/batches', methods=['GET'])
def batches():
    return render_template('batches.html')

#categories code
@views.route('/categories', methods=['GET', 'POST'])
def categories():
    if request.method == 'POST':
        #batchId = "BA" + f"{(len(Batches.query.all())):03}"
        categoryId = "CA"+ f"{(len(Category.query.all())):03}"
        categoryName = request.form.get('categoryName')
        categoryStatus = bool(request.form.get('categoryStatus'))
        categoryComments = request.form.get('categoryComments')
        print(categoryId, categoryName, categoryStatus, categoryComments)
        new_category = Category(categoryId=categoryId, categoryName=categoryName, categoryStatus=categoryStatus, categoryComments=categoryComments)
        db.session.add(new_category)
        db.session.commit()
    categories=Category.query.all()
    return render_template('categories.html', categories=categories[::-1], listAll=True)

@views.route('/categories/<categoryId>', methods=['DELETE'])
def deleteCategory(categoryId):
    category = Category.query.get(categoryId)
    if category:
        db.session.delete(category)
        db.session.commit()
    return jsonify({})

@views.route('/categories/<searchBy>/<searchConstraint>')
def searchCategory(searchBy, searchConstraint):
    if searchBy == 'id':
        categories = Category.query.filter(Category.categoryId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'name':
        categories = Category.query.filter(Category.categoryName.like("%"+searchConstraint+"%")).all()
    return render_template('categories.html', categories=categories, listAll=False)

@views.route('/categories/<categoryId>', methods=['PUT','PATCH'])
def editCategory(categoryId):
    category = Category.query.get_or_404(categoryId)
    value = json.loads(request.data)
    category.categoryId=value['categoryId']
    category.categoryName=value['categoryName']
    category.categoryStatus=value['categoryStatus']
    category.categoryComments=value['categoryComments']
    db.session.add(category)
    db.session.commit()
    return jsonify({})

#qualification code
@views.route('/qualification')
def qualifications():
    if request.method == 'POST':
        qualificationId = qualificationId
        qualificationName = request.form.get('qualificationName')
        qualificationStatus = bool(request.form.get('qualificationStatus'))
        print(qualificationId, qualificationName, qualificationStatus)
        new_qualification = Qualifications(qualificationId=qualificationId, qualificationName=qualificationName, qualificationStatus=qualificationStatus)
        db.session.add(new_qualification)
        db.session.commit()
    qualifications=Qualifications.query.all()
    return render_template('qualification.html',qualifications=qualifications[::-1], listAll=True)

@views.route('/qualification/<qualificationId>', methods=['DELETE'])
def deleteQualification(qualificationId):
    qual = Qualifications.query.get(qualificationId)
    if qual:
        db.session.delete(qual)
        db.session.commit()
    return jsonify({})

@views.route('/qualification/<searchBy>/<searchConstraint>')
def searchQualification(searchBy, searchConstraint):
    if searchBy == 'id':
        qual = Qualifications.query.filter(Qualifications.qualificationId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'name':
        qual = Qualifications.query.filter(Qualifications.qualificationName.like("%"+searchConstraint+"%")).all()
    return render_template('qualification.html', qual=qual, listAll=False)

@views.route('/qualification/<qualificationId>', methods=['PUT','PATCH'])
def editQualification(qualificationId):
    qual = Qualifications.query.get_or_404(qualificationId)
    value = json.loads(request.data)
    qual.qualificationId=value['qualificationId']
    qual.qualificationName=value['qualificationName']
    qual.qualificationStatus=value['qualificationStatus']
    db.session.add(qual)
    db.session.commit()
    return jsonify({})