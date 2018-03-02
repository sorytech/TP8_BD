--########## DROP TABLE IN DATABASE #####################################
DROP TABLE LesSpectacles;
DROP TABLE LesReprésentations;
DROP TABLELesRéservations;
--########## CREAT TABLE IN DATABASE ####################################
--########## CREATION DE LA TABLE LesSpectacles #########################
CREATE TABLE LesSpectacles(
	numS NUMBER(4) PRIMARY KEY,
	nomS CHAR(20) NOT NULL);
--########## CREATION DE LA TABLE LesReprésentations ####################
CREATE TABLE LesReprésentations(
	numS NUMBER(4),	
	dateRep DATE CHECK(dateRep > SYSDATE),	
	nbplacespossibles NUMBER(7) CHECK(nbplacespossibles > 0),
	PRIMARY KEY(numS,dateRep),
	FOREIGN KEY(numS) REFERENCES LesSpectacles(numS));
--########## CREATION DE LA TABLE LesRéservations ######################
CREATE TABLE LesRéservations(
	idclient NUMBER(4),	
	numS NUMBER(4),	
	dateRep DATE,	
	nbplaces NUMBER(7) CHECK(nbplaces > 0),
	FOREIGN KEY(numS,dateRep) REFERENCES LesReprésentations(numS,dateRep));
