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
# endw

get '/' do
  @restaurants = Restaurant.all
  erb :index
end

get '/restaurants/new' do
  erb :restaurant_new
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  puts @restaurant
  erb :restaurant
end

post '/restaurants/new' do
  puts params[:photo_name][:filename]
  puts params[:photo_name][:tempfile]

  @filename = params[:photo_name][:filename]
  file = params[:photo_name][:tempfile]

  File.open("./public/restaurant_photos/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end

  @restaurant = Restaurant.new(name: params[:name], phone_number: params[:phone_number], photo_name: params[:photo_name][:filename])
  @restaurant.save
  erb :restaurant
end
