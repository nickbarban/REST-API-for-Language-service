/*All languages' are stored in language table*/
create table language (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name varchar(30)  NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

/* Populate language Table */
INSERT INTO language(name)
VALUES ('english');

INSERT INTO language(name)
VALUES ('spanish');

INSERT INTO language(name)
VALUES ('russian');

INSERT INTO language(name)
VALUES ('japanese');

INSERT INTO language(name)
VALUES ('german');

INSERT INTO language(name)
VALUES ('french');

INSERT INTO language(name)
VALUES ('korean');

INSERT INTO language(name)
VALUES ('italian');

INSERT INTO language(name)
VALUES ('turkish');

INSERT INTO language(name)
VALUES ('polish');

INSERT INTO language(name)
VALUES ('ukrainian');

/*All users' are stored in user table*/
create table user (
id BIGINT NOT NULL AUTO_INCREMENT,
	   login VARCHAR(30) NOT NULL,
	   password VARCHAR(100) NOT NULL,
	   name VARCHAR(30) NOT NULL,
	   email VARCHAR(30) NOT NULL,
	   state VARCHAR(30) NOT NULL DEFAULT 'Active',
	   lang_id BIGINT  NOT NULL, 
	   created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	   updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	   PRIMARY KEY (id),
	   CONSTRAINT FK_user_language FOREIGN KEY (lang_id) REFERENCES language (id),
	   UNIQUE (login)
);
  
/* user_profile table contains all possible roles */
create table user_profile(
   id BIGINT NOT NULL AUTO_INCREMENT,
   type VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (type)
);
  
/* JOIN TABLE for MANY-TO-MANY relationship*/ 
CREATE TABLE user_user_profile (
    user_id BIGINT NOT NULL,
    user_profile_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, user_profile_id),
    CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES user (id),
    CONSTRAINT FK_user_profile FOREIGN KEY (user_profile_id) REFERENCES user_profile (id)
);
 
/* Populate user_profile Table */
INSERT INTO user_profile(type)
VALUES ('user');
 
INSERT INTO user_profile(type)
VALUES ('ADMIN');
 
INSERT INTO user_profile(type)
VALUES ('DBA');


/* Populate user Table */
INSERT INTO user(login, password, name, email, state, lang_id)
VALUES ('bill','abc123', 'Bill', 'bill@xyz.com', 'Active', 1);
 
INSERT INTO user(login, password, name, email, state, lang_id)
VALUES ('danny','abc124', 'Danny', 'danny@xyz.com', 'Active', 1);
 
INSERT INTO user(login, password, name, email, state, lang_id)
VALUES ('sam','abc125', 'Sam', 'samy@xyz.com', 'Active', 1);
 
INSERT INTO user(login, password, name, email, state, lang_id)
VALUES ('nicole','abc126', 'Nicole', 'nicloe@xyz.com', 'Active', 1);
 
INSERT INTO user(login, password, name, email, state, lang_id)
VALUES ('kenny','abc127', 'Kenny', 'kenny@xyz.com', 'Active', 1);
 
/* Populate JOIN Table */
INSERT INTO user_user_profile (user_id, user_profile_id)
  SELECT user.id, profile.id FROM user user, user_profile profile  
  where user.login='bill' and profile.type='user';
 
INSERT INTO user_user_profile (user_id, user_profile_id)
  SELECT user.id, profile.id FROM user user, user_profile profile
  where user.login='danny' and profile.type='user';
 
INSERT INTO user_user_profile (user_id, user_profile_id)
  SELECT user.id, profile.id FROM user user, user_profile profile
  where user.login='sam' and profile.type='ADMIN';
 
INSERT INTO user_user_profile (user_id, user_profile_id)
  SELECT user.id, profile.id FROM user user, user_profile profile
  where user.login='nicole' and profile.type='DBA';
 
INSERT INTO user_user_profile (user_id, user_profile_id)
  SELECT user.id, profile.id FROM user user, user_profile profile  
  where user.login='kenny' and profile.type='user';

INSERT INTO user_user_profile (user_id, user_profile_id)
  SELECT user.id, profile.id FROM user user, user_profile profile  
  where user.login='kenny' and profile.type='ADMIN';
 
create table course (
id BIGINT NOT NULL AUTO_INCREMENT,
	   name VARCHAR(30) NOT NULL,
	   lang_id BIGINT  NOT NULL,
	   created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	   updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	   PRIMARY KEY (id),
	   CONSTRAINT FK_course_language FOREIGN KEY (lang_id) REFERENCES language (id),
	   UNIQUE (name)
);
