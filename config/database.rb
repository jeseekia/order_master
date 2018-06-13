require 'pg'
$connection = PG::Connection.open(dbname: 'restaurant_db')
require 'active_record'

ActiveRecord::Base.establish_connection(
  host: 'localhost',
  adapter: 'postgresql',
  encoding: 'utf-8',
  database: 'restaurant_db'
)
