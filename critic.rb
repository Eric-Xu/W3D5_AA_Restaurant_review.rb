require_relative 'restaurant_db'
require_relative 'restaurant'
require_relative 'restaurant_review'

class Critic
  def self.find(id)
  	# [ {x, y, z} ]
  	critics_data = RestaurantDB.execute(<<-SQL, id)
	  SELECT *
        FROM critics
       WHERE critics.id = ?
  	SQL

  	critics_data.empty? ? nil : Critic.new(critics_data[0]['screen_name'],
  									                       critics_data[0]['id'])
  end

  attr_reader :id
  attr_accessor :screen_name

  def initialize(screen_name, id=nil)
    @screen_name = screen_name
    @id = id
  end

  def reviews_given
    RestaurantReview.reviews_given(self.id)
  end

  def average_score_given
    RestaurantReview.average_score_given(self.id)
  end

  def unreviewed_restaurants
    RestaurantReview.unreviewed_restaurants(self.id)
  end
end