import csv
import re

def simplified(name):
    #print(re.sub(r'[^a-zA-Z]', '', name))
    return re.sub(r'[^a-zA-Z]', '', name)

courses_file = open('courses.csv','r')
courses_reader = csv.reader(courses_file)

courses2 = []

for i in courses_reader:
    if len(i) > 0:
        courses2.append(i[0])
#print(courses2)

dict = {}
for i in courses2:
    dict[simplified(i)] = i
#print(dict)
#print(len(courses2)) #unique courses 43
courses_file.close()

db_file = open('stud_db.csv','r')
db_reader = csv.reader(db_file)
db = list(db_reader)
#print(db)
db2 = []
for i in db:
    i[2] = i[2].lstrip().strip().upper()
    db2.append(i)

for row in db2:
    if simplified(row[2]) in dict.keys():
        row[2] = dict[simplified(row[2])]
print(db2)
db_file.close()

db_file = open('stud_db.csv','w')
db_writer = csv.writer(db_file)
db_writer.writerows(db2)
db_file.close()

