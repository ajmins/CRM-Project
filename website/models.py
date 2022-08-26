from . import db

class UserBatch(db.Model):
    id = db.Column(db.Integer, primary_key=True) # primary key
    userId = db.Column(db.Integer, db.ForeignKey('users.userId')) #foreign key
    batchId = db.Column(db.String(80), db.ForeignKey('batches.batchId')) #foreign key

    # def __init__(self, userId, batchId):
    #     self.userId = userId
    #     self.batchId = batchId

class UserQualification(db.Model):
    id = db.Column(db.Integer, primary_key=True) #primary key
    userId = db.Column(db.Integer, db.ForeignKey('users.userId')) #foreign key
    qualificationId = db.Column(db.Integer, db.ForeignKey('qualifications.qualificationId')) #foreign key


    # def __init__(self, userId, courseId):
    #     self.userId = userId
    #     self.courseId = courseId

class CourseEnrollment(db.Model):
    id = db.Column(db.Integer, primary_key=True) #primary key
    userId = db.Column(db.Integer, db.ForeignKey('users.userId')) #foreign key
    courseId = db.Column(db.String(80), db.ForeignKey('courses.courseId')) #foreign key
    batchId = db.Column(db.String(80), db.ForeignKey('batches.batchId')) #foreign key
    enrollStatus = db.Column(db.String(80))
    score = db.Column(db.Integer)

    # def __init__(self, userId, courseId, batchId, enrollStatus, score):
    #     self.userId = userId
    #     self.courseId = courseId
    #     self.batchId = batchId
    #     self.enrollStatus = enrollStatus
    #     self.score = score

class Batches(db.Model):
    batchId = db.Column(db.String(80), nullable=False, primary_key=True) #primary key
    batchName = db.Column(db.String(80), nullable=False)
    batchCourseId = db.Column(db.String(80), db.ForeignKey('courses.courseId'), nullable=False) #foreign key
    batchStatus = db.Column(db.Boolean, default=True)
    batchStrength = db.Column(db.Integer)
    batchStartDate = db.Column(db.DateTime, nullable=False)
    batchEndDate = db.Column(db.DateTime, nullable=False)

    enrollments = db.relationship('CourseEnrollment')
    users = db.relationship('UserBatch')
    
    # def __init__(self, batchName, batchId, batchStartDate, batchEndDate, batchStatus, batchStrength):
    #     self.batchName = batchName
    #     self.batchId = batchId
    #     self.batchStartDate = batchStartDate
    #     self.batchEndDate = batchEndDate
    #     self.batchStatus = batchStatus
     #   self.batchStrength = batchStrength

class Enquiries(db.Model):
    enquiryId = db.Column(db.Integer, primary_key=True) #primary key
    enquiryUserId = db.Column(db.Integer, db.ForeignKey('users.userId')) #foreign key
    enquiryCourseId = db.Column(db.String(80), db.ForeignKey('courses.courseId')) #foreign key
    enquiryDescription = db.Column(db.String(250))
    enquiryStatus = db.Column(db.Boolean, default=True)

    # def __init__(self, enquiryId, enquiryUserId, enquiryCourseId, enquiryDescription, enquiryStatus):
    #     self.enquiryId = enquiryId
    #     self.enquiryUserId = enquiryUserId
    #     self.enquiryCourseId = enquiryCourseId
    #     self.enquiryDescription = enquiryDescription
    #     self.enquiryStatus = enquiryStatus

class Courses(db.Model):
    courseId = db.Column(db.String(80), nullable=False, primary_key=True) #primary key
    courseName = db.Column(db.String(80), nullable=False)
    courseCategoryId = db.Column(db.String(80), db.ForeignKey('category.categoryId'), nullable=False) #foreign key
    courseDuration = db.Column(db.String(80))
    courseDescription = db.Column(db.String(80))
    courseInstructorID = db.Column(db.Integer, db.ForeignKey('instructor.instructorId')) #foreign key
    courseMinQualificationId = db.Column(db.Integer, db.ForeignKey('qualifications.qualificationId')) #foreign key
    courseBatchSize = db.Column(db.Integer)
    courseVideoLink = db.Column(db.String(80))
    courseSyllabus = db.Column(db.LargeBinary)
    courseRating = db.Column(db.Integer)
    courseStatus = db.Column(db.Boolean, default=True)


    batches = db.relationship('Batches')
    enquiries = db.relationship('Enquiries')
    enrollments = db.relationship('CourseEnrollment')

    
    # def __init__(self, courseName, courseCategory, courseId, courseDuration, courseDescription, courseInstructorID, courseMinQualificationId, courseBatchSize, courseVideoLink, courseSyllabus, courseStatus):
    #     self.courseName = courseName
    #     self.coursecategory = courseCategory
    #     self.courseId = courseId
    #     self.courseDuration = courseDuration
    #     self.courseDescription = courseDescription
    #     self.courseInstructorID = courseInstructorID
    #     self.courseMinQualificationId = courseMinQualificationId
    #     self.courseBatchSize = courseBatchSize
    #     self.courseVideoLink = courseVideoLink
    #     self.courseSyllabus = courseSyllabus
    #     self.courseStatus = courseStatus

class ActivityLog(db.Model):
    id = db.Column(db.Integer, primary_key=True) #primary key
    userId = db.Column(db.Integer, db.ForeignKey('users.userId')) #foreign key
    time = db.Column(db.DateTime, default=db.func.now())

    # def __init__(self, userId, time):
    #     self.userId = userId
    #     self.time = time

class Users(db.Model):
    userId = db.Column(db.Integer, primary_key=True, autoincrement=True) #primary key
    userName = db.Column(db.String(80), nullable=False)
    userPassword = db.Column(db.String(250), nullable=False)
    userRoleId = db.Column(db.Integer, db.ForeignKey('role.roleId'), nullable=False) #foreign key
    userEmail = db.Column(db.String(80), nullable=False)
    userPhone = db.Column(db.String(80), nullable=False)
    userCountry = db.Column(db.String(80), nullable=False)
    userState = db.Column(db.String(80), nullable=False)
    userCity = db.Column(db.String(80), nullable=False)

    enquiries = db.relationship('Enquiries')
    activityLog = db.relationship('ActivityLog')
    enrollments = db.relationship('CourseEnrollment')
    qualifications = db.relationship('UserQualification')
    batches = db.relationship('UserBatch')

    # def __init__(self, userName, userPassword, userRole, userEmail, userPhone, userCountry, userState, userCity):
    #     self.userName = userName
    #     self.userPassword = userPassword
    #     self.userRole = userRole
    #     self.userEmail = userEmail
    #     self.userPhone = userPhone
    #     self.userCountry = userCountry
    #     self.userState = userState
    #     self.userCity = userCity

class Category(db.Model):

    categoryId = db.Column(db.String(80), primary_key=True) #primary key
    categoryName = db.Column(db.String(80))
    categoryStatus = db.Column(db.Boolean, default=True)
    categoryComments = db.Column(db.String(250))
    courses = db.relationship('Courses')
    
    # def __init__(self, categoryName, categoryId, categoryStatus, categoryComments):
    #     self.categoryName = categoryName
    #     self.categoryId = categoryId
    #     self.categoryStatus = categoryStatus
    #     self.categoryComments = categoryComments

class Qualifications(db.Model):
    qualificationId = db.Column(db.Integer, nullable=False, primary_key=True) #primary key
    qualificationName = db.Column(db.String(80), nullable=False)
    qualificationStatus = db.Column(db.Boolean, default=True)
    
    courses = db.relationship('Courses')
    users = db.relationship('UserQualification')
    
    # def __init__(self, qualificationName, qualificationId, qualificationStatus):
    #     self.qualificationName = qualificationName
    #     self.qualificationId = qualificationId
    #     self.qualificationStatus = qualificationStatus

class Role(db.Model):
    roleId = db.Column(db.Integer, primary_key=True) #primary key
    roleName = db.Column(db.String(80), nullable=False)
    users = db.relationship('Users')


    # def __init__(self, roleId, roleName):
    #     self.roleId = roleId
    #     self.roleName = roleName

class Instructor(db.Model):
    instructorId = db.Column(db.Integer, nullable=False, primary_key=True, autoincrement=True) #primary key
    instructorName = db.Column(db.String(80), nullable=False) 
    instructorEmail = db.Column(db.String(80))
    instructorPhone = db.Column(db.String(80))
    courses = db.relationship('Courses')

    # def __init__(self, instructorName, instructorId, instructorEmail, instructorPhone):
    #     self.instructorName = instructorName
    #     self.instructorId = instructorId
    #     self.instructorEmail = instructorEmail
    #     self.instructorPhone = instructorPhone

    
