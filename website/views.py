from flask import Blueprint, render_template, request
from .models import Category, Courses, Qualifications
from . import db

views = Blueprint('views', __name__)

@views.route('/batches', methods=['GET'])
def batches():
    return render_template('batches.html', categories= Category.query.all())

@views.route('/categories')
def categories():
    return render_template('categories.html', categories= Category.query.all())
 
@views.route('/qualification')
def qualifications():
    return render_template('qualification.html')

@views.route('/courses', methods=['GET', 'POST'])
def courses():
    if request.method == 'POST':
        if request.form.get('methordId') == 'put':
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
            courseId = request.form.get('courseId')
            print(courseId)
            c = Courses.query.get(courseId)
            print(c)
            c.courseName = courseName
            c.courseCategoryId = courseCategoryId
            c.courseDuration = courseDuration
            c.courseMinQualification = courseMinQualification
            c.courseInstructorId = courseInstructorId
            c.courseStatus = courseStatus
            c.courseDescription = courseDescription
            c.courseBatchSize = courseBatchSize
            #c.courseSyllabus = courseSyllabus
            c.courseVideoLink = courseVideoLink
            db.session.commit()

            return render_template('courses.html', courses = Courses.query.all(), categories = Category.query.all(), qualifications = Qualifications.query.all()) 
        else:
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
            return render_template('courses.html', courses=Courses.query.all(), categories= Category.query.all(), qualifications= Qualifications.query.all())
    else:
        return render_template('courses.html', courses = Courses.query.all(), categories = Category.query.all(), qualifications = Qualifications.query.all())