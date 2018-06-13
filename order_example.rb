# require 'pg'
require 'sinatra'
require_relative 'config/database'
require_relative 'models/restaurant'

# set :public_folder, File.dirname(__FILE__) + '/static'



# get '/' do
#   'Hello world!'
#
#   # result.each do |restaurant|
#   #  # puts restaurant
#   #   puts "#{restaurant['name']}: #{restaurant['phone_number']}"
#   # end
#
#   restaurants = Restaurant.all.map do |restaurant|
#     "<li>#{restaurant['name']}</li>"
#   end
#
#   "<h1>Restaurants</h1><ul>#{restaurants.join(',')}</ul>"
# end

get '/' do
  @restaurants = Restaurant.all
  erb :index
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  puts @restaurant
  erb :restaurant
end
