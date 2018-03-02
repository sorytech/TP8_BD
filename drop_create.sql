--############################## DROP TABLE IN DATABASE #####################################
DROP TABLE LesReservations;
DROP TABLE LesRepresentations;
DROP TABLE LesSpectacles;

--############################## CREAT TABLE IN DATABASE ####################################
--############################## CREATION DE LA TABLE LesSpectacles #########################
CREATE TABLE LesSpectacles(
	numS NUMBER(4) PRIMARY KEY,
	nomS CHAR(20) NOT NULL);
--############################## CREATION DE LA TABLE LesReprésentations ####################
CREATE TABLE LesRepresentations(
	numS NUMBER(4),	
	dateRep DATE ,	
	nbplacespossibles NUMBER(7) CHECK(nbplacespossibles > 0),
	PRIMARY KEY(numS,dateRep),
	FOREIGN KEY(numS) REFERENCES LesSpectacles(numS));
--############################## CREATION DE LA TABLE LesRéservations ######################
CREATE TABLE LesReservations(
	idclient NUMBER(4),	
	numS NUMBER(4),	
	dateRep DATE,	
	nbplaces NUMBER(7) CHECK(nbplaces > 0),
	PRIMARY KEY(idclient,numS,dateRep),
	FOREIGN KEY(numS,dateRep) REFERENCES LesRepresentations(numS,dateRep));
--############################## CREATION DU TRIGGER NbrPlacesPossibles ####################
Create or replace trigger NbrPlacesPossibles
Before insert on LesReservations
For each row
Declare
	NbDisponible integer;
	NbPlaceReserve integer;
Begin
	select nbplacespossibles into NbDisponible from LesRepresentations 
	where dateRep=:new.dateRep and numS=:new.numS;
	select sum(nbplaces) into NbPlaceReserve from LesReservations where dateRep=:new.dateRep and numS=:new.numS;
	If NbDisponible - NbPlaceReserve < :new.nbplaces 
		then raise_application_error(-20100,'Impossible, Plus de place disponible'); end if;
end;
/ 
--############################## CREATION DU TRIGGER DateFuture ####################
Create or replace trigger DateFuture
Before insert on LesRepresentations
For each row

Begin
	If (:new.dateRep < sysdate) then raise_application_error(-20100,'Impossible, Date depassée'); end if;
end;
/ 
--############################## CREATION DU TRIGGER LesSpectaclesInclusLesRepresentations ####################
Create or replace trigger LesSpectaclesInclusLesRepresentations
Before insert on LesRepresentations
For each row

Begin
	If (:new.dateRep < sysdate) then raise_application_error(-20100,'Impossible ajouter une representation'); end if;
end;
/ 
--############################## CREATION DU TRIGGER LesRepresentationsInclusLesReservations ####################
Create or replace trigger LesRepresentationsInclusLesReservations
Before insert on LesRepresentations
For each row

Begin
	If (:new.dateRep < sysdate) then raise_application_error(-20100,'Impossible ajouter une representation'); end if;
end;
/ 


	


