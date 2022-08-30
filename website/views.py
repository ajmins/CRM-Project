from flask import Blueprint, render_template, request, jsonify, url_for, redirect
from . import db
from .models import Category, Batches, Courses, Users, ActivityLog
import json
from sqlalchemy import func, Date
from datetime import date

views = Blueprint('views', __name__)

categories =[]

@views.route('/dashboard')
def dashboard():
    users = Users.query.all()
    dates = ActivityLog.query.with_entities(func.cast(ActivityLog.time, Date).label('Date'), func.count(ActivityLog.userId).label('logincount')).group_by(func.cast(ActivityLog.time, Date)).all()
    # dates = ActivityLog.query(cast(ActivityLog.time, Date)).distinct().all()
    return render_template('dashboard.html', users=users, dates=dates)

@views.route('/users')
def  users():
    users = Users.query.all()
    if request.args :
        print(request.args.get('roles').split(','))
        listAll = False
        users = Users.query.filter(Users.userRoleId.in_(request.args.get('roles').split(','))).all()
        if len(request.args.get('roles').split(',')) == 2:
            listAll = True
        elif request.args.get('roles').split(',') == ['']:
            listAll = True
            users = Users.query.all()
        return render_template('users.html', users=users, listAll=listAll)
    return render_template('users.html', users=users, listAll=True)

@views.route('/users/<searchBy>/<searchConstraint>')
def searchUser(searchBy, searchConstraint):
    if searchBy == 'id':
        users = Users.query.filter(Users.userId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'name':
        users = Users.query.filter(Users.userName.like("%"+searchConstraint+"%")).all()
    return render_template('users.html', users=users, listAll=False)

@views.route('/batches', methods=['GET', 'POST'])
def batches():
    if request.method == 'POST':
        batchId = "BA" + f"{(len(Batches.query.all())):03}"
        batchName = request.form.get('batchName')
        batchStrength = int(request.form.get('batchStrength'))
        batchCourseId = request.form.get('batchCourseId')
        batchStatus = bool(request.form.get('batchStatus'))
        batchStartDate = request.form.get('batchStartDate')
        batchEndDate = request.form.get('batchEndDate')
        print(batchStatus)
        new_batch = Batches(batchId=batchId,batchName=batchName,batchStrength=batchStrength,batchCourseId=batchCourseId,batchStatus=batchStatus,batchStartDate=batchStartDate,batchEndDate=batchEndDate)
        db.session.add(new_batch)
        db.session.commit()
    batches = Batches.query.all()
    courses = Courses.query.with_entities(Courses.courseId, Courses.courseName).distinct().all()
    categories = Category.query.with_entities(Category.categoryId, Category.categoryName).distinct().all()
    if request.args :
        print(request.args.get('categories').split(','))
        listAll = False
        batches = Batches.query.filter(Batches.batchStatus.in_((request.args.get('categories')).split(','))).all()
        if len(request.args.get('categories').split(',')) == 2:
            listAll = True
        elif request.args.get('categories').split(',') == ['']:
            listAll = True
            batches = Batches.query.all()
        return render_template('batches.html', batches=batches[::-1], listAll=listAll, courses=courses, categories=categories)
    return render_template('batches.html', batches=batches[::-1], listAll=True, courses=courses, categories=categories)

@views.route('/batches/<batchId>', methods=['DELETE'])
def deleteBatch(batchId):
    batch = Batches.query.get(batchId)
    if batch:
        db.session.delete(batch)
        db.session.commit()
    return jsonify({})

@views.route('/batches/<batchId>', methods=['PUT', 'PATCH'])
def editBatch(batchId):
    batch = Batches.query.get_or_404(batchId)
    value = json.loads(request.data)
    batch.batchId = value['batchId']
    batch.batchName = value['batchName']
    batch.batchStrength = value['batchStrength']
    batch.batchCourseId = value['batchCourseId']
    batch.batchStatus = value['batchStatus']
    batch.batchStartDate = value['batchStartDate']
    batch.batchEndDate = value['batchEndDate']
    db.session.add(batch)
    db.session.commit()
    return jsonify({})


@views.route('/batches/<searchBy>/<searchConstraint>')
def searchBatch(searchBy, searchConstraint):
    months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    if searchBy == 'id':
        batches = Batches.query.filter(Batches.batchId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'name':
        batches = Batches.query.filter(Batches.batchName.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'date':
        dateList = searchConstraint.split()
        print(dateList)
        searchConstraint = dateList[2] + "-" + f"{(months.index(dateList[0])+1):02}" + "-" + f"{dateList[1][:-1]:02}"
        print(searchConstraint)
        batches = Batches.query.filter(Batches.batchStartDate.like("%"+searchConstraint+"%")).all()
    courses = Courses.query.with_entities(Courses.courseId, Courses.courseName).distinct().all()
    categories = Category.query.with_enitities(Category.categoryId, Category.categoryName).distinct().all()
    return render_template('batches.html', batches=batches[::-1], listAll=False, courses=courses, categories=categories)

@views.route('/categories', methods=['GET', 'POST'])
def categories():
    if request.method == 'POST':
        categoryId = request.form.get('categoryId')
        categoryName = request.form.get('categoryName')
        categoryStatus = bool(request.form.get('categoryStatus'))
        categoryComments = request.form.get('categoryComments')
        print(categoryId, categoryName, categoryStatus, categoryComments)
        new_category = Category(categoryId=categoryId, categoryName=categoryName, categoryStatus=categoryStatus, categoryComments=categoryComments)
        db.session.add(new_category)
        db.session.commit()
    categories=Category.query.all()
    return render_template('categories.html', categories=categories, listAll=True)

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

@views.route('/qualifications')
def qualifications():
    return render_template('qualification.html')