CREATE TABLE SNABDUVACI(
	snabduvac_id INTEGER PRIMARY KEY,
  	ime_s VARCHAR(10),
  	saldo NUMERIC,
  	grad VARCHAR(20)
);

CREATE TABLE PROIZVODI(
	proizvod_id INTEGER,
  	vid INTEGER,
  	ime_p VARCHAR(50),
  	boja VARCHAR(15),
  	tezina NUMERIC,
  	grad_p VARCHAR(20),

  	CONSTRAINT primary_keys PRIMARY KEY(proizvod_id, vid)
);

CREATE TABLE PONUDI(
	ponuda_id INTEGER,
  	snabduvac_id INTEGER,
  	proizvod_id INTEGER,
  	proizvod_vid INTEGER,
  	kolicina_naracka INTEGER,
  	datum_naracka DATE,
  	kolicina_isporaka INTEGER,
  	datum_isporaka DATE,

  	CONSTRAINT priamry_key PRIMARY KEY(ponuda_id),
  	CONSTRAINT SNABDUVAC_fk FOREIGN KEY (snabduvac_id) REFERENCES SNABDUVACI(snabduvac_id) ON DELETE SET NULL ON UPDATE CASCADE,
  	CONSTRAINT PROIZVODI_fk FOREIGN KEY (proizvod_id, proizvod_vid) REFERENCES PROIZVODI(proizvod_id, vid) ON DELETE SET NULL ON UPDATE CASCADE
);