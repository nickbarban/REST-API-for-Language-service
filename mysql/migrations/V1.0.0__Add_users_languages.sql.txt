/*All Languages' are stored in LANGUAGE table*/
create table LANGUAGE (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name varchar(30)  NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

/* Populate LANGUAGE Table */
INSERT INTO LANGUAGE(name)
VALUES ('english');

INSERT INTO LANGUAGE(name)
VALUES ('spanish');

INSERT INTO LANGUAGE(name)
VALUES ('russian');

INSERT INTO LANGUAGE(name)
VALUES ('japanese');

INSERT INTO LANGUAGE(name)
VALUES ('german');

INSERT INTO LANGUAGE(name)
VALUES ('french');

INSERT INTO LANGUAGE(name)
VALUES ('korean');

INSERT INTO LANGUAGE(name)
VALUES ('italian');

INSERT INTO LANGUAGE(name)
VALUES ('turkish');

INSERT INTO LANGUAGE(name)
VALUES ('polish');

INSERT INTO LANGUAGE(name)
VALUES ('ukrainian');

/*All Users' are stored in USER table*/
create table USER (
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
	   CONSTRAINT FK_LANGUAGE FOREIGN KEY (lang_id) REFERENCES LANGUAGE (id),
	   UNIQUE (login)
);
  
/* USER_PROFILE table contains all possible roles */
create table USER_PROFILE(
   id BIGINT NOT NULL AUTO_INCREMENT,
   type VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (type)
);
  
/* JOIN TABLE for MANY-TO-MANY relationship*/ 
CREATE TABLE USER_USER_PROFILE (
    user_id BIGINT NOT NULL,
    user_profile_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, user_profile_id),
    CONSTRAINT FK_USER FOREIGN KEY (user_id) REFERENCES USER (id),
    CONSTRAINT FK_USER_PROFILE FOREIGN KEY (user_profile_id) REFERENCES USER_PROFILE (id)
);
 
/* Populate USER_PROFILE Table */
INSERT INTO USER_PROFILE(type)
VALUES ('USER');
 
INSERT INTO USER_PROFILE(type)
VALUES ('ADMIN');
 
INSERT INTO USER_PROFILE(type)
VALUES ('DBA');


/* Populate USER Table */
INSERT INTO USER(login, password, name, email, state, lang_id)
VALUES ('bill','abc123', 'Bill', 'bill@xyz.com', 'Active', 1);
 
INSERT INTO USER(login, password, name, email, state, lang_id)
VALUES ('danny','abc124', 'Danny', 'danny@xyz.com', 'Active', 1);
 
INSERT INTO USER(login, password, name, email, state, lang_id)
VALUES ('sam','abc125', 'Sam', 'samy@xyz.com', 'Active', 1);
 
INSERT INTO USER(login, password, name, email, state, lang_id)
VALUES ('nicole','abc126', 'Nicole', 'nicloe@xyz.com', 'Active', 1);
 
INSERT INTO USER(login, password, name, email, state, lang_id)
VALUES ('kenny','abc127', 'Kenny', 'kenny@xyz.com', 'Active', 1);
 
/* Populate JOIN Table */
INSERT INTO USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM USER user, USER_PROFILE profile  
  where user.login='bill' and profile.type='USER';
 
INSERT INTO USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM USER user, USER_PROFILE profile
  where user.login='danny' and profile.type='USER';
 
INSERT INTO USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM USER user, USER_PROFILE profile
  where user.login='sam' and profile.type='ADMIN';
 
INSERT INTO USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM USER user, USER_PROFILE profile
  where user.login='nicole' and profile.type='DBA';
 
INSERT INTO USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM USER user, USER_PROFILE profile  
  where user.login='kenny' and profile.type='USER';

INSERT INTO USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM USER user, USER_PROFILE profile  
  where user.login='kenny' and profile.type='ADMIN';
 
