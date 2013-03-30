require_relative 'restaurant_db'
require_relative 'chef'
require_relative 'restaurant_review'

class Restaurant
  def self.find(id)
  	# [ {x, y, z} ]
  	restaurants_data = RestaurantDB.execute(<<-SQL, id)
	  SELECT *
        FROM restaurants
       WHERE restaurants.id = ?
  	SQL

  	restaurants_data.empty? ? nil : Restaurant.new(restaurants_data[0]['name'],
  									  			   restaurants_data[0]['neighborhood'], 
  									  			   restaurants_data[0]['cuisine'], 
  									  			   restaurants_data[0]['id'] )
  end

  def self.by_neighborhood(neighborhood)
  	# [ {w, x}, {y, z} ]
  	restaurants_data = RestaurantDB.execute(<<-SQL, neighborhood)
	  SELECT *
        FROM restaurants
       WHERE restaurants.neighborhood = ?
  	SQL

    restaurants_data.map do |restaurant_data|
      Restaurant.new(restaurant_data['name'],
      				 restaurant_data['neighborhood'], 
      				 restaurant_data['cuisine'],
      				 restaurant_data['id']) 
	end 
  end

  attr_reader :id
  attr_accessor :name, :neighborhood, :cuisine

  def initialize(name, neighborhood, cuisine,id=nil)
    @name = name
    @neighborhood = neighborhood
    @cuisine = cuisine
    @id = id
  end

  def reviews_received
  	RestaurantReview.reviews_received(self.id)
  end

  def average_score_received
  	RestaurantReview.average_score_received(self.id)
  end
end