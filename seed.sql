DROP TABLE IF EXISTS role_table;
DROP TABLE IF EXISTS specialisation_table;
DROP TABLE IF EXISTS cohort_table;
DROP TABLE IF EXISTS user_table;

CREATE TABLE role_table(
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE specialisation_table(
	specialisation_id SERIAL PRIMARY KEY,
	specialisation_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE cohort_table(
	cohort_id SERIAL PRIMARY KEY,
	cohort_name VARCHAR(100) UNIQUE NOT NULL,
	specialisation_id INT REFERENCES specialisation_table(specialisation_id)
);

CREATE TABLE user_table(
	user_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	cohort_id INT REFERENCES cohort_table(cohort_id),
	role_id INT REFERENCES role_table(role_id)
);

INSERT INTO role_table (role_name)
VALUES
	('Trainer'),
	('Trainee'),
	('Admin');

INSERT INTO specialisation_table (specialisation_name)
VALUES
	('SDET'),
	('DevOps'),
	('Management');

INSERT INTO cohort_table (cohort_name, specialisation_id)
VALUES
	('Engineering-22', 2),
	('Richmond-Management', 3);

INSERT INTO user_table (first_name, last_name, email, password, cohort_id, role_id)
VALUES
	('Anthony', 'Ushedo', 'antz@sparta.com', 'password', 1, 2),
	('Moe', 'El-Zein', 'moe@sparta.com', 'password', 1, 2),
	('Laura', 'Green', 'lgreen@sparta.com', 'password', 1, 2);
