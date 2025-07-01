use studentcoursedb;
# Subquery in SELECT: Show each student's total enrollments
SELECT  Name,
    (SELECT COUNT(*) 
     FROM enrollment 
     WHERE enrollment.StudentID = student.StudentID) AS TotalEnrollments
FROM student;

# Subquery with IN: Students who are enrolled

SELECT Name 
FROM student 
WHERE StudentID IN (
    SELECT StudentID 
    FROM enrollment
);

# Subquery with EXISTS: Courses that have at least one enrollment

SELECT CourseName 
FROM course 
WHERE EXISTS (
    SELECT * 
    FROM enrollment 
    WHERE enrollment.CourseID = course.CourseID
);

# Correlated subquery in WHERE: Students with more than 1 course
SELECT Name 
FROM student 
WHERE (
    SELECT COUNT(*) 
    FROM enrollment 
    WHERE enrollment.StudentID = student.StudentID
) > 1;

# Subquery in FROM: Average number of courses per student
SELECT AVG(course_count) AS AvgCourses
FROM (
    SELECT StudentID, COUNT(*) AS course_count
    FROM enrollment
    GROUP BY StudentID
) AS summary;