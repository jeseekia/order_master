require 'active_record'

class Restaurant < ActiveRecord::Base
  # def self.all
  #   $connection.exec_params('SELECT * FROM restaurants');
  # end
  #
  # def self.find(id)
  #   $connection.exec_params('SELECT * FROM restaurants where id = '+ id.to_s)[0];
  # end
end