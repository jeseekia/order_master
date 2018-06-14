# require 'pg'
require 'sinatra'
require_relative 'config/database'
require_relative 'models/restaurant'
require_relative 'models/menu_item'

get '/' do
  @restaurants = Restaurant.all
  erb :index
end

get '/restaurants/new' do
  erb :restaurant_new
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  @menu_items = Menu_item.where('restaurant_id': @restaurant['id'])
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
