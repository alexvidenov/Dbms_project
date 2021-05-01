# Dbms_project

Term project for Database management systems classes. 

## Tables

### Students

Contains info about the student like faculty number, names, studying year, form of education, specific level of education, group and semester number. 
1:1 relation with a project. 
m:1 relation with groups. 
m:1 relation with levels of education. 


### Projects

Contains specifics about the project: annual production program, classifier, topic, as well as information concerning the student - when was the task given, when it has to be defended, the respective marks that the student received after that date, and also all of the consultations that took place before the end date. 
1:1 relation with a student, marks, and 1:m with consultations. 


### Marks

Contains 5 marks given from each one of the jury, the average mark and the final mark. 
1:1 relation with a project. 


### Consultations: 

Contains the date when a certain project consultation was held. 
m:1 relation with projects. 


### Groups 

Contains the number of the group, holding a number of students. 
1:m relation with students. 


### Educational levels

Contains the description of the educational level (for ex: master, bachelor, etc). 
1:m relation with students.