from flask import Blueprint, render_template, request
from .models import Category, Courses

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
        courseName = request.form.get('courseName')
        courseCategory = request.form.get('courseCategory')
        courseQualification = request.form.get('courseQualification')
        courseInstructor = request.form.get('courseInstructor')
        courseStatus = request.form.get('courseStatus')
        courseComments = request.form.get('courseComments')

        

        # course = Courses(courseName=courseName, courseCategory=courseCategory, courseQualification=courseQualification, courseInstructor=courseInstructor, courseStatus=courseStatus, courseComments=courseComments)
        # db.session.add(course)
        # db.session.commit()
        return render_template('courses.html', categories= Category.query.all())
    elif request.method == 'GET':
        return render_template('courses.html', courses = Courses.query.all())
