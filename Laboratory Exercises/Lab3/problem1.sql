CREATE TABLE employees
(
    ssn INTEGER,
    email VARCHAR(50),
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    city VARCHAR(20),
    street VARCHAR(50),
    streetNumber VARCHAR(10),

    PRIMARY KEY (ssn)
);

CREATE TABLE employeeTelephoneNumbers
(
    employeeSSN INTEGER,
    telephoneNumber VARCHAR(15),

    CONSTRAINT primary_key PRIMARY KEY (employeeSSN, telephoneNumber),
    CONSTRAINT employee_fk FOREIGN KEY (employeeSSN) REFERENCES employees(ssn)
);

CREATE TABLE agent_managers
(
    employeeSSN INTEGER,

    PRIMARY KEY (employeeSSN),
    CONSTRAINT employee_fk FOREIGN KEY (employeeSSN) REFERENCES employees(ssn)
);

CREATE TABLE stores
(
    storeID INTEGER,
    storeName VARCHAR(30),
    storeAddress VARCHAR(50),

    PRIMARY KEY (storeID)
);

CREATE TABLE sellers
(
    employeeSSN INTEGER,
    workExperience VARCHAR(50),
    numberWorkPlaces INTEGER,
    responsibleAgentSSN INTEGER,
    storeID INTEGER,

    PRIMARY KEY (employeeSSN),
    CONSTRAINT employee_fk FOREIGN KEY (employeeSSN) REFERENCES employees(ssn),
    CONSTRAINT responsible_agent_fk FOREIGN KEY (responsibleAgentSSN) REFERENCES agent_managers(employeeSSN),
    CONSTRAINT store_fk FOREIGN KEY (storeID) REFERENCES stores(storeID)
);

CREATE TABLE agents
(
    employeeSSN INTEGER,

    PRIMARY KEY (employeeSSN),
    CONSTRAINT employee_fk FOREIGN KEY (employeeSSN) REFERENCES employees(ssn)
);




CREATE TABLE agent_sellers
(
    employeeSSN INTEGER,

    PRIMARY KEY (employeeSSN),
    CONSTRAINT employee_fk FOREIGN KEY (employeeSSN) REFERENCES employees(ssn)
);

CREATE TABLE agent_seller_languages
(
    employeeSSN INTEGER,
    lang VARCHAR(20),

    PRIMARY KEY (employeeSSN, lang),
    CONSTRAINT employee_fk FOREIGN KEY (employeeSSN) REFERENCES agent_sellers(employeeSSN)
);



CREATE TABLE customers
(
    ssn INTEGER,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    email VARCHAR(50),
    alternativeEmail VARCHAR(50),
    telephoneNumber VARCHAR(15),
    deliveryAddress VARCHAR(50),
    paymentType VARCHAR(20),
    responsibleAgentSellerSSN INTEGER,

    PRIMARY KEY (ssn),
    CONSTRAINT responsible_agent_fk FOREIGN KEY (responsibleAgentSellerSSN) REFERENCES agent_sellers(employeeSSN)
);

CREATE TABLE categories
(
    categoryID INTEGER,
    categoryName VARCHAR(20),
    masterCategoryID INTEGER,

    PRIMARY KEY (categoryID),
    CONSTRAINT master_category_fk FOREIGN KEY (masterCategoryID) REFERENCES categories(categoryID)
);

CREATE TABLE products
(
    code INTEGER,
    productName VARCHAR(20),
    productionCountry VARCHAR(50),
    price INTEGER,
    categoryID INTEGER,

    PRIMARY KEY (code),
    CONSTRAINT category_fk FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);



CREATE TABLE talks
(
    talkID INTEGER,
    goal VARCHAR(20),
    talkDate DATE,
    talkDuration INTEGER,

    agentSellerSSN INTEGER,
    customerSSN INTEGER,

    PRIMARY KEY (talkID),

    CONSTRAINT agent_seller_fk FOREIGN KEY (agentSellerSSN) REFERENCES agent_sellers(employeeSSN),
    CONSTRAINT customer_fk FOREIGN KEY (customerSSN) REFERENCES customers(ssn) ON DELETE CASCADE
);

CREATE TABLE store_review
(
    storeID INTEGER,
    customerSSN INTEGER,
    grade INTEGER,
    reviewComment VARCHAR(200),

    PRIMARY KEY (storeID, customerSSN),
    CONSTRAINT store_fk FOREIGN KEY(storeID) REFERENCES stores(storeID),
    CONSTRAINT customer_fk FOREIGN KEY(customerSSN) REFERENCES customers(ssn) ON DELETE SET NULL
);

CREATE TABLE product_review
(
    productCode INTEGER,
    customerSSN INTEGER,
    grade INTEGER,
    reviewComment VARCHAR(200),

    PRIMARY KEY (productCode, customerSSN),
    CONSTRAINT product_fk FOREIGN KEY(productCode) REFERENCES products(code),
    CONSTRAINT customer_fk FOREIGN KEY(customerSSN) REFERENCES customers(ssn) ON DELETE SET NULL
);

CREATE TABLE product_stock
(
    storeID INTEGER,
    productCode INTEGER,
    quantity INTEGER,

    PRIMARY KEY(storeID, productCode),
    CONSTRAINT store_fk FOREIGN KEY(storeID) REFERENCES stores(storeID),
    CONSTRAINT product_fk FOREIGN KEY(productCode) REFERENCES products(code)
);

CREATE TABLE purchase
(
    purchaseID INTEGER,
    sellerSSN INTEGER,
    customerSSN INTEGER,
    productCode INTEGER,
    quantity INTEGER,

    PRIMARY KEY (purchaseID),

    CONSTRAINT seller_fk FOREIGN KEY(sellerSSN) REFERENCES sellers(employeeSSN),
    CONSTRAINT customer_fk FOREIGN KEY (customerSSN) REFERENCES customers(ssn),
    CONSTRAINT product_fk FOREIGN KEY (productCode) REFERENCES products(code)
);


-- 1.
ALTER TABLE products ADD CONSTRAINT unique_name UNIQUE(productName);

-- 2.
ALTER TABLE product_review ADD CONSTRAINT grade_domain CHECK ( grade in (1,2,3) );
ALTER TABLE store_review ADD CONSTRAINT grade_domain CHECK ( grade in (1,2,3,4,5) );

-- 3.
ALTER TABLE customers ADD CONSTRAINT payment_type CHECK(paymentType in ('so karticka', 'vo gotovo'));

-- 4.
ALTER TABLE employeeTelephoneNumbers ADD CONSTRAINT number_format CHECK(telephoneNumber SIMILAR TO '07\d\/\d\d\d-\d\d\d' OR
                                                                        telephoneNumber SIMILAR TO '02\d{4}-\d{3}');

-- 5.
-- Specified during the creation of the appropriate tables

-- 6.
ALTER TABLE customers ALTER COLUMN responsibleAgentSellerSSN SET NOT NULL;

-- 7.
ALTER TABLE customers ADD CONSTRAINT different_emails CHECK (email != customers.alternativeEmail);

-- 8.
ALTER TABLE sellers ADD CONSTRAINT non_negative_work_places CHECK(numberWorkPlaces >= 0);

-- 9.
ALTER TABLE sellers ALTER COLUMN storeID SET NOT NULL;

-- 10.
-- ON DELETE CASCADE in the talks table on the customer FK

-- 11.
-- ON DELETE SET NULL in the store_review and product_review tables.