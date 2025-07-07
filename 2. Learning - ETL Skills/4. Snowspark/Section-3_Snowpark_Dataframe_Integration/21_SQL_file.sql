USE test.public;

-- inline JSON data
SELECT PARSE_JSON($1) AS src
FROM (VALUES
('{ 
    "date" : "2017-04-28", 
    "dealership" : "Valley View Auto Sales",
    "salesperson" : {
        "id": "55",
        "name": "Frank Beasley"
    },
    "customer" : [{
        "name": "Joyce Ridgely",
        "phone": "16504378889",
        "address": "San Francisco, CA"
    }],
    "vehicle" : [{
        "make": "Honda",
        "model": "Civic",
        "year": "2017",
        "price": "20275",
        "extras": ["ext warranty", "paint protection"]
    }]
}'),
('{ 
    "date" : "2017-04-28", 
    "dealership" : "Tindel Toyota",
    "salesperson" : {
        "id": "274",
        "name": "Greg Northrup"
    },
    "customer" : [{
        "name": "Bradley Greenbloom",
        "phone": "12127593751",
        "address": "New York, NY"
    }],
    "vehicle" : [{
        "make": "Toyota", 
        "model": "Camry", 
        "year": "2017", 
        "price": "23500", 
        "extras": ["ext warranty", "rust proofing", "fabric protection"]
    }]
}')) v;

CREATE OR REPLACE TABLE car_sales(src variant) AS
SELECT PARSE_JSON($1) AS src
FROM (VALUES
('{ 
    "date" : "2017-04-28", 
    "dealership" : "Valley View Auto Sales",
    "salesperson" : {
        "id": "55",
        "name": "Frank Beasley"
    },
    "customer" : [{
        "name": "Joyce Ridgely",
        "phone": "16504378889",
        "address": "San Francisco, CA"
    }],
    "vehicle" : [{
        "make": "Honda",
        "model": "Civic",
        "year": "2017",
        "price": "20275",
        "extras": ["ext warranty", "paint protection"]
    }]
}'),
('{ 
    "date" : "2017-04-28", 
    "dealership" : "Tindel Toyota",
    "salesperson" : {
        "id": "274",
        "name": "Greg Northrup"
    },
    "customer" : [{
        "name": "Bradley Greenbloom",
        "phone": "12127593751",
        "address": "New York, NY"
    }],
    "vehicle" : [{
        "make": "Toyota", 
        "model": "Camry", 
        "year": "2017", 
        "price": "23500", 
        "extras": ["ext warranty", "rust proofing", "fabric protection"]
    }]
}')) v;

SELECT *
FROM car_sales;

-- JSON data from staged file (in NDJSON format)
TRUNCATE car_sales;

COPY INTO car_sales
FROM @stage1/car-sales.ndjson
    FILE_FORMAT = (type = JSON);

SELECT *
FROM car_sales;

-- traversing JSON data
SELECT src:dealership::string,
    src:salesperson.name::string,
    src['salesperson']['name'],
    src:customer[0].name,
    src:vehicle[0],
    src:vehicle[0].price::int,
    GET(src:vehicle[0], 'make'),
    GET_PATH(src:vehicle, '[0]')
FROM car_sales
ORDER BY 1;

CREATE OR REPLACE FILE FORMAT json_format TYPE='JSON';

SELECT $1:customer[0].name::string
FROM @stage1/car-sales.ndjson (file_format => 'json_format');

-- flattening JSON data
SELECT *
FROM car_sales, LATERAL FLATTEN(src:vehicle[0]);

SELECT value, value:make, value:extras
FROM car_sales, LATERAL FLATTEN(src:vehicle);

SELECT v.value as vehicle, e.value as extras
FROM car_sales,
    LATERAL FLATTEN(src:vehicle) v,
    LATERAL FLATTEN(v.value:extras) e;
