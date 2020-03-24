DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value NUMERIC,
  year_built INT,
  no_of_bedrooms INT
);
