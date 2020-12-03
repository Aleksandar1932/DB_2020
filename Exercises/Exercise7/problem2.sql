CREATE TABLE SNABDUVACI
(
    snabduvac_id INTEGER PRIMARY KEY,
    ime_s        VARCHAR(10) NOT NULL,
    saldo        NUMERIC,
    grad         VARCHAR(20) DEFAULT 'Skopje',

    constraint ime_s_unique UNIQUE (ime_s),
    constraint saldo_greater_than_zero CHECK ( saldo > 0 )
);

CREATE TABLE PROIZVODI
(
    proizvod_id INTEGER,
    vid         INTEGER,
    ime_p       VARCHAR(50) NOT NULL,
    boja        VARCHAR(15),
    tezina      NUMERIC,
    grad_p      VARCHAR(20),

    CONSTRAINT primary_keys PRIMARY KEY (proizvod_id, vid),
    CONSTRAINT grad_p_pre_defined CHECK (grad_p IN ('Paris', 'London', 'Rome'))
);

CREATE TABLE PONUDI
(
    ponuda_id         INTEGER,
    snabduvac_id      INTEGER,
    proizvod_id       INTEGER,
    proizvod_vid      INTEGER,
    kolicina_naracka  INTEGER,
    datum_naracka     DATE,
    kolicina_isporaka INTEGER,
    datum_isporaka    DATE,

    CONSTRAINT priamry_key PRIMARY KEY (ponuda_id),
    CONSTRAINT SNABDUVAC_fk FOREIGN KEY (snabduvac_id) REFERENCES SNABDUVACI (snabduvac_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT PROIZVODI_fk FOREIGN KEY (proizvod_id, proizvod_vid) REFERENCES PROIZVODI (proizvod_id, vid) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT kolicina_isporaka CHECK (kolicina_isporaka <= kolicina_naracka)
);