BEGIN TRANSACTION;
DELETE FROM assignment;
INSERT INTO users
  (username,password_hash,role) VALUES
  ('teacher','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_TEACHER');
INSERT INTO users
  (username,password_hash,role) VALUES
  ('student','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');

INSERT INTO course
  (name, description, class_size) VALUES
  ('test','this is a test course', '25');

INSERT INTO teacher (teacher, course) VALUES
  ((SELECT user_id FROM users WHERE username = 'teacher'), (SELECT id FROM course WHERE name = 'test'));

INSERT INTO student (student, course) VALUES
  ((SELECT user_id FROM users WHERE username = 'user'), (SELECT id FROM course WHERE name = 'test'));

INSERT INTO curriculum
  (course, date, lesson) VALUES
  ((SELECT id FROM course WHERE name='test'), '2020-02-02', 'test curriculum');
  
INSERT INTO curriculum
  (course, date, lesson) VALUES
  ((SELECT id FROM course WHERE name='second test curriculum'), '2020-02-06', 'test curriculum again?!?!');

INSERT INTO assignment (due_date, questions, course) VALUES ('2020-02-22', 3 , (SELECT id FROM course WHERE name = 'test'));
INSERT INTO assignment (due_date, questions, course) VALUES ('2020-02-24', 10 , (SELECT id FROM course WHERE name = 'test'));


INSERT INTO curriculum
  (course, date, lesson, homework) VALUES
  ((SELECT id FROM course WHERE name='test'), '2020-02-20', 'test curriculum with homework', (SELECT id FROM assignment WHERE due_date = '2020-02-22'));

INSERT INTO question 
  (assignment, number, type, statement) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 1, 'mc', 'test multiple choice');

INSERT INTO question 
  (assignment, number, type, statement) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 2, 'mmc', 'test multiple multiple choice');

INSERT INTO question 
  (assignment, number, type, statement) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 3, 'text', 'test text');

INSERT INTO mcchoice
  (assignment, question, choice, answer, correct) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 1, 1, 'incorrect', false);
INSERT INTO mcchoice
  (assignment, question, choice, answer, correct) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 1, 2, 'correct', true);
INSERT INTO mcchoice
  (assignment, question, choice, answer, correct) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 2, 1, 'incorrect', false);
INSERT INTO mcchoice
  (assignment, question, choice, answer, correct) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 2, 2, 'correct', true);
INSERT INTO mcchoice
  (assignment, question, choice, answer, correct) VALUES
  ((SELECT id FROM assignment WHERE due_date = '2020-02-22'), 2, 3, 'also correct', true);

INSERT INTO answer (student, assignment, question, answer) VALUES
  ((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE due_date = '2020-02-22'), 1, '1');
INSERT INTO answer (student, assignment, question, answer) VALUES
  ((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE due_date = '2020-02-22'), 2, '1,2');
INSERT INTO answer (student, assignment, question, answer) VALUES
  ((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE due_date = '2020-02-22'), 3, 'test answer');

INSERT INTO grade (student, assignment, turned_in, correct, grade) VALUES
  ((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE due_date = '2020-02-22'), '2020-02-20 02:20', 2, 80);

INSERT INTO message (user_id, read, content) VALUES
  ((SELECT user_id FROM users WHERE username = 'student'), false, 'assignment graded');
INSERT INTO message (user_id, read, content) VALUES
  ((SELECT user_id FROM users WHERE username = 'student'), true, 'new assignment');

COMMIT TRANSACTION;






