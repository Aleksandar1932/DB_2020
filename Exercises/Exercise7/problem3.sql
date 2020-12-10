CREATE TABLE korisnik
(
    korisnikID     INTEGER,
    korisnichkoIme VARCHAR(50) UNIQUE,
    lozinka        VARCHAR(20),
    email          VARCHAR(70),

    PRIMARY KEY (korisnikID)
);

CREATE TABLE market
(
    marketID    INTEGER,
    ime         VARCHAR(50),
    adresa      VARCHAR(50),
    grad        VARCHAR(50),
    rejting     INTEGER,
    rakovoditel VARCHAR(50),
    vremeOd     TIME,
    vremeDo     TIME,

    primary key (marketID)
);

CREATE TABLE specijalitet
(
    kod INTEGER,
    ime VARCHAR(20),
    tip VARCHAR(20),

    PRIMARY KEY (kod)
);

CREATE TABLE narachka
(
    narachkaID INTEGER,
    marketID INTEGER,
    specijalitetKod INTEGER,
    korisnikID INTEGER,
    datum DATE,

    PRIMARY KEY (narachkaID),
    CONSTRAINT market_fk FOREIGN KEY (marketID) REFERENCES market(marketID) ON DELETE CASCADE ,
    CONSTRAINT specijalitet_fk FOREIGN KEY (specijalitetKod) REFERENCES specijalitet(kod) ON DELETE CASCADE,
    CONSTRAINT  korisnik_fk FOREIGN KEY (korisnikID) REFERENCES korisnik (korisnikID) ON DELETE SET NULL,

    CONSTRAINT datum_check CHECK ( datum > '2010/10/20' )
);

CREATE TABLE adresiDostava(
    narachkaID INTEGER,
    adresa VARCHAR(100),

    PRIMARY KEY (narachkaID, adresa),
    CONSTRAINT narachka_fk FOREIGN KEY (narachkaID) REFERENCES narachka(narachkaID),
    CONSTRAINT adresa_format CHECK (adresa SIMILAR TO '[A-Z a-z]+-\d+\/[A-Z][A-Z a-z]+')
);

INSERT INTO korisnik (korisnikID, korisnichkoIme, lozinka, email) VALUES (1,'aleksandar1932','aleksandar','aleksandar.ivanovski123@gmail.com');
INSERT INTO korisnik (korisnikID, korisnichkoIme, lozinka, email) VALUES (2,'sanja1932','sanja','sanja.petrova123@gmail.com');

INSERT INTO market (marketID, ime, adresa, grad, rejting, rakovoditel, vremeOd, vremeDo) VALUES (1, 'market1','adresa1','Strumica',10,'bat vase','08:00:00', '16:00:00');
INSERT INTO market (marketID, ime, adresa, grad, rejting, rakovoditel, vremeOd, vremeDo) VALUES (2, 'market2','adresa2','Strumica',10,'bat ice','08:00:00', '16:00:00');


Insert into specijalitet (kod, ime, tip) VALUES (1,'specijalitet1','salama');

insert into narachka (narachkaID, marketID, specijalitetKod, korisnikID, datum) VALUES (1, 1,1,1,'2020/12/10');
insert into narachka (narachkaID, marketID, specijalitetKod, korisnikID, datum) VALUES (3, 2,1,1,'2020/12/10');
insert into narachka (narachkaID, marketID, specijalitetKod, korisnikID, datum) VALUES (2, 1,1,2,'2020/12/10');

insert into adresiDostava (narachkaID, adresa) VALUES (1, 'Aleksan-31/SKOPJE');

insert into adresiDostava (narachkaID, adresa) VALUES (1, 'JE');

DELETE From korisnik WHERE korisnik.korisnikID = 2;
delete from market where market.marketID=2;

UPDATE specijalitet SET tip='salamka' WHERE kod = 1;