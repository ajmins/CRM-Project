from flask import Blueprint, render_template, request, jsonify, url_for, redirect
from . import db
from .models import Category, Batches, Courses, Enquiries, Users
import json

views = Blueprint('views', __name__)

categories =[]
batches =[]
enquiries = []

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