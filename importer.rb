require 'pg'

connection = PG.connect(
  host: 'clinickpg',
  dbname: 'postgres',
  user: 'postgres',
  password: '123456'
)

setup_table = %{
  DROP TABLE IF EXISTS result_tests;
  
  CREATE TABLE result_tests (
    id SERIAL PRIMARY KEY,
    cpf VARCHAR(20),
    name VARCHAR(250)
  )
}

connection.exec(setup_table)

insert_data_sql = %{
  INSERT INTO result_tests (cpf, name) 
  VALUES ('123456', 'leandro), 
  ('333333', 'joão')")
}

connection.exec(insert_data_sql)

