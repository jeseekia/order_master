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
  @menu_items = Menu_Item.where('restaurant_id': @restaurant['id'])
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
  @menu_items = Menu_Item.where('restaurant_id': @restaurant['id'])
  erb :restaurant
end

get '/restaurants/edit/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :restaurant_edit
end

post '/restaurants/edit/:id' do
  puts params[:photo_name][:filename]
  puts params[:photo_name][:tempfile]

  @filename = params[:photo_name][:filename]
  file = params[:photo_name][:tempfile]

  File.open("./public/restaurant_photos/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  
  @restaurant = Restaurant.find(params[:id])
  @restaurant.update(name: params[:name])
  @restaurant.update(phone_number: params[:phone_number])
  @restaurant.update(photo_name: params[:photo_name][:filename])
  @restaurant.save
  @menu_items = Menu_Item.where('restaurant_id': @restaurant['id'])
  erb :restaurant
end

post '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  @menu_items = Menu_Item.where('restaurant_id': @restaurant['id'])
  @menu_items = Menu_Item.new(restaurant_id: params[:id], price: params[:price], name: params[:name])
  @menu_items.save
  @menu_items = Menu_Item.where('restaurant_id': @restaurant['id'])
  erb :restaurant
end
