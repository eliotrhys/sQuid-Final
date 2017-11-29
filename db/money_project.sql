DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE wallets;

CREATE TABLE wallets(
  id SERIAL8 PRIMARY KEY,
  wallet_amount INT2
);

CREATE TABLE tags(
  id SERIAL8 PRIMARY KEY,
  tag VARCHAR(255)
);

CREATE TABLE merchants(
  id SERIAL8 PRIMARY KEY,
  merchant_name VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL8 PRIMARY KEY,
  amount INT4,
  merchant_id INT2 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT2 REFERENCES tags(id) ON DELETE CASCADE,
  transaction_date DATE,
  comment VARCHAR(255)
);
