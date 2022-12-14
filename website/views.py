from flask import Blueprint, render_template, request, jsonify, url_for, redirect
from . import db

from .models import Category, Batches, Courses, Enquiries, Users, Qualifications, ActivityLog, Instructor

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

batches =[]
enquiries = []

#batches
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

    return render_template('batches.html', batches=batches[::-1], listAll=True, courses=courses)


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

    return render_template('batches.html', batches=batches, listAll=False)




    courses = Courses.query.with_entities(Courses.courseId, Courses.courseName).distinct().all()
    categories = Category.query.with_entities(Category.categoryId, Category.categoryName).distinct().all()
    return render_template('batches.html', batches=batches[::-1], listAll=False, courses=courses, categories=categories)

    return render_template('batches.html', batches=batches, listAll=False)


@views.route('/enquiries', methods=['GET', 'POST'])
def enquiries():
    if request.method == 'POST':
        enquiryId = request.form.get('enquiryId')
        enquiryUserId = request.form.get('enquiryUserId')
        enquiryCourseId = request.form.get('enquiryCourseId')
        enquiryStatus = bool(request.form.get('enquiryStatus'))
        enquiryDescription = request.form.get('enquiryDescription')
        print(enquiryId, enquiryUserId, enquiryStatus, enquiryDescription)
        new_enquiry = Enquiries(enquiryId=enquiryId, enquiryUserId=enquiryUserId, enquiryCourseId=enquiryCourseId, enquiryStatus=enquiryStatus, enquiryDescription=enquiryDescription)
        db.session.add(new_enquiry)
        db.session.commit()
    enquiries=Enquiries.query.all()
    courses = Courses.query.with_entities(Courses.courseId, Courses.courseName).distinct().all()
    users = Users.query.with_entities(Users.userId).distinct().all()
    enquiryStatus = Enquiries.query.with_entities(Enquiries.enquiryStatus).distinct().all()
    return render_template('enquiries.html', enquiries=enquiries[::-1], listAll=True, users=users, courses=courses, enquiryStatus=enquiryStatus)

@views.route('/enquiries/<enquiryId>', methods=['DELETE'])
def deleteEnquiry(enquiryId):
    enquiry = Enquiries.query.get(enquiryId)
    if enquiry:
        db.session.delete(enquiry)
        db.session.commit()
    return jsonify({})

@views.route('/enquiries/<searchBy>/<searchConstraint>')
def searchEnquiry(searchBy, searchConstraint):
    courses = Courses.query.with_entities(Courses.courseId, Courses.courseName).distinct().all()
    if searchBy == 'id':
        enquiries = Enquiries.query.filter(Enquiries.enquiryId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'uid':
        enquiries = Enquiries.query.filter(Enquiries.enquiryUserId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'name':
        enquiries = Enquiries.query.filter(Enquiries.enquiryCourseId.like("%"+searchConstraint+"%")).all()
    
    return render_template('enquiries.html', enquiries=enquiries, courses=courses, listAll=False)

@views.route('/enquiries/<enquiryId>', methods=['PUT', 'PATCH'])
def editEnquiry(enquiryId):
    enquiry = Enquiries.query.get_or_404(enquiryId)
    value = json.loads(request.data)
    enquiry.enquiryUserId = value['enquiryUserId']
    enquiry.enquiryCourseId = value['enquiryCourseId']
    enquiry.enquiryDescription = value['enquiryDescription']
    enquiry.enquiryStatus = bool(value['enquiryStatus'])
    db.session.add(enquiry)
    db.session.commit()
    print(value)
    return jsonify({})


#categories
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


@views.route('/courses', methods=['GET', 'POST'])
def courses():
    if request.method == 'POST':
        courseName = request.form.get('courseName')
        courseCategoryId = request.form.get('courseCategoryId')
        courseDuration = request.form.get('courseDuration')
        courseMinQualification = request.form.get('courseMinQualification')
        courseInstructorId = request.form.get('courseInstructorId')
        courseStatus = request.form.get('courseStatus') in ['true', 'True', '1']
        courseDescription = request.form.get('courseDescription')
        courseBatchSize = request.form.get('courseBatchSize')
        courseSyllabus = request.form.get('courseSyllabus')
        courseVideoLink = request.form.get('courseUrl')
        courseId = courseCategoryId+courseName+'0'
        for i in Courses.query.all():
            if i.courseId == courseId:
                courseId = courseCategoryId+courseName+str(int(i.courseId[-1])+1)
        course = Courses(courseName=courseName, courseId=courseId, courseCategoryId=courseCategoryId, courseDuration=courseDuration, courseMinQualificationId=courseMinQualification, courseInstructorID=courseInstructorId, courseStatus=courseStatus, courseDescription=courseDescription, courseBatchSize=courseBatchSize, courseVideoLink=courseVideoLink, courseSyllabus=None)
        db.session.add(course)
        db.session.commit()   
    if request.args.get('status'):
        print(request.args.get('status').split(',')) 
        listAll = False
        courses = Courses.query.filter(Courses.courseStatus.in_((request.args.get('status')).split(','))).all()
        if len(request.args.get('status').split(',')) == 2:
            listAll = True
        elif request.args.get('status').split(',') == ['']:
            listAll = True
            courses = Courses.query.all()
        print(courses)
        return render_template('courses.html', courses = courses[::-1], categories = Category.query.all(), qualifications = Qualifications.query.all(), instructors=Instructor.query.all(), listAll = listAll)
    return render_template('courses.html', courses = Courses.query.all()[::-1], categories = Category.query.all(), qualifications = Qualifications.query.all(), instructors=Instructor.query.all(), listAll = True)

@views.route('/courses/<courseId>', methods=['PUT', 'PATCH'])
def editCourse(courseId):
    c = Courses.query.get_or_404(courseId)
    value = json.loads(request.data)
    print(value)
    c.courseName = value['courseName']
    c.courseCategoryId = value['courseCategoryId']
    c.courseDuration = value['courseDuration']
    c.courseStatus = value['courseStatus'] in ['true', 'True', '1']
    c.courseDescription = value['courseDescription']
    c.courseMinQualificationId = value['courseMinQualificationId']
    c.courseBatchSize = value['courseBatchSize']
    c.courseInstructorID = value['courseInstructorId']
    c.courseSyllabus = None
    c.courseVideoLink = value['courseUrl']
    c.courseRating = None
    print(value)
    db.session.add(c)
    db.session.commit()
    return jsonify({})

# Search Course
@views.route('/courses/<searchBy>/<searchConstraint>')
def searchCourse(searchBy, searchConstraint):
    if searchBy == 'id':
        courses = Courses.query.filter(Courses.courseId.like("%"+searchConstraint+"%")).all()
    elif searchBy == 'name':
        courses = Courses.query.filter(Courses.courseName.like("%"+searchConstraint+"%")).all()
    return render_template('courses.html', courses=courses, categories = Category.query.all(), qualifications = Qualifications.query.all(), instructors=Instructor.query.all(), listAll=False)

# Delete Course
@views.route('/courses/<courseId>', methods=['DELETE'])
def deleteCourse(courseId):
    course = Courses.query.get(courseId)
    if course:
        db.session.delete(course)
        db.session.commit()
    return jsonify({})

# #categories code
# @views.route('/categories', methods=['GET', 'POST'])
# def categories():
#     if request.method == 'POST':
#         #batchId = "BA" + f"{(len(Batches.query.all())):03}"
#         categoryId = "CA"+ f"{(len(Category.query.all())):03}"
#         categoryName = request.form.get('categoryName')
#         categoryStatus = bool(request.form.get('categoryStatus'))
#         categoryComments = request.form.get('categoryComments')
#         print(categoryId, categoryName, categoryStatus, categoryComments)
#         new_category = Category(categoryId=categoryId, categoryName=categoryName, categoryStatus=categoryStatus, categoryComments=categoryComments)
#         db.session.add(new_category)
#         db.session.commit()
#     categories=Category.query.all()
#     return render_template('categories.html', categories=categories[::-1], listAll=True)

# @views.route('/categories/<categoryId>', methods=['DELETE'])
# def deleteCategory(categoryId):
#     category = Category.query.get(categoryId)
#     if category:
#         db.session.delete(category)
#         db.session.commit()
#     return jsonify({})

# @views.route('/categories/<searchBy>/<searchConstraint>')
# def searchCategory(searchBy, searchConstraint):
#     if searchBy == 'id':
#         categories = Category.query.filter(Category.categoryId.like("%"+searchConstraint+"%")).all()
#     elif searchBy == 'name':
#         categories = Category.query.filter(Category.categoryName.like("%"+searchConstraint+"%")).all()
#     return render_template('categories.html', categories=categories, listAll=False)

# @views.route('/categories/<categoryId>', methods=['PUT','PATCH'])
# def editCategory(categoryId):
#     category = Category.query.get_or_404(categoryId)
#     value = json.loads(request.data)
#     category.categoryId=value['categoryId']
#     category.categoryName=value['categoryName']
#     category.categoryStatus=value['categoryStatus']
#     category.categoryComments=value['categoryComments']
#     db.session.add(category)
#     db.session.commit()

#     return jsonify({})