-- Example 1
DROP TABLE IF EXISTS Persons;
CREATE TABLE if not EXISTS Persons(
	PersonID INTEGER,
  	FirstName VARCHAR(20),
  	LastName VARCHAR(20),
  	Age INTEGER,
  
  	CONSTRAINT person_pk PRIMARY KEY(PersonID)
);

Drop table if EXISTS Orders;
create table if not EXISTS Orders(
	OrderID INteger,
  	OrderNumber INTEGER,
  	PersonID INTEGER,
  
  	CONSTRAINT order_pk PRIMARY KEy(OrderID),
  	CONSTRAINT person_fk FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

-- Example 2
drop table if exists Snabduvaci;
create table if not exists Snabduvaci(
	SnabduvacID INTEGER,
  	FirstName VARCHAR(20),
  	Balance DOUBLE,
  	City VARCHAR(30) DEFAULT 'Skopje',
  
  	constraint snabduvaci_pk PRIMARY KEY(SnabduvacID),
  	CONSTRAINT firstname_not_null CHECK(firstname not NULL),
  	CONSTRAINT balance_positive CHECK (Balance > 0)
);

Drop table if EXISTS Proizvodi;
Create table if not exists Proizvodi(
	ProizvodID INTEGER,
  	ProizvodType VARCHAR(50),
  	Name VARCHAR(50),
  	Color VARCHAR(50),
  	Weight DOUBLE,
	ManufacturingCity varchar(30),
  
  	constraint proizvodi_pk PRIMARY KEY(ProizvodID, ProizvodType),
  	CONSTRAINT name_not_null CHECK(Name is not null),
  	CONSTRAINT name_unique UNIQUE(Name),
  	constraint manufacturingcity_domain CHECK(manufacturingcity in ('London', 'Paris', 'Rome'))
  
);

drop table if exists Ponudi;
create table if not exists Ponudi(
	PonudaID integer,
  	SnabduvacID integer,
  	ProizvodID Integer,
  	ProizvodType Varchar(50),
  	OrderQuantity DOUBLE,
  	OrderDate Date,
  	ShippedQuantity double,
  	ShippingDate Date,
  
  	CONSTRAINT ponudi_pk PRIMARY KEY(PonudaID),
 	CONSTRAINT snabduvac_fk FOREIGN KEY (SnabduvacID) REFERENCES Snabduvaci(SnabduvacID) on delete cascade on update cascade,
  	CONSTRAINT proizvod_fk FOREIGN KEY (ProizvodID, ProizvodType) REFERENCES Proizvodi(ProizvodID, ProizvodType) on delete set NULL on update cascade,
  	constraint quantites_constraint CHECK(shippedquantity <= orderquantity)
);

--Example 3
drop table if EXISTS Narachka;
create table if not exists Narachka(
	NarachkaID integer,
  	MarketID integer,
  	SpecijalitetID varchar(50),
  	KorisnikID integer,
  	OrderDate date,
  
  	CONSTRAINT narachka_pk PRIMARY KEY(NarachkaID),
  	constraint market_fk FOREIGN KEY(MarketID) REFERENCES Market(MarketID) on delete cascade on update CASCADE,
  	constraint specijalitet_fk FOREIGN KEY(SpecijalitetID) REFERENCES Specijalitet(SpecijalitetID) on delete CASCADE on update CASCADE,
  	Constraint korisnik_fk FOREIGN KEY(KorisnikID) REFERENCES Korisnik(KorisnikID) on delete set NULL on update CASCADE,
  	constraint orderdate_minimum CHECK(OrderDate > '2010-10-20')
);

drop table if EXISTS Korisnik;
create table if not EXISTS Korisnik(
	KorisnikID integer,
  	Username VARCHAR(50),
  	Password varchar(20),
  	Email varchar(50),
  
  	CONSTRAINT korisnik_pk PRIMARY KEY(KorisnikID)
);

drop table if EXISTS Market;
create table if not exists Market(
	MarketID integer,
  	Name varchar(50),
  	Address varchar(50),
  	City varchar(50),
  	Rating	integer,
  	Manager	varchar(50),
  	OpenTime Time,
  	CloseTime Time,
  
  	constraint market_pk PRIMARY KEY(MarketID)
);

drop table if EXISTS Specijalitet;
create table if not exists Specijalitet(
	SpecijalitetID varchar(50),
  	Name varchar(50),
  	Type varchar(50),
  
  	constraint specijalitet_pk PRIMARY KEY(SpecijalitetID)
);

drop table if EXISTS AdresiDostava;
create table if not exists AdresiDostava(
	NarachkaID integer,
  	Address varchar(50),
  	
  	CONSTRAINT adresidostava_pk PRIMARY KEY(NarachkaID, Address),
  	constraint narachka_fk FOREIGN KEY(NarachkaID) REFERENCES Narachka(NarachkaID),
  	constraint adress_format check(Address LIKE '%-/%')
);
