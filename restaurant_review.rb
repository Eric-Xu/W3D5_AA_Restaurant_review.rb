require_relative 'restaurant_db'
require_relative 'critic'
require_relative 'restaurant'

class RestaurantReview

  def self.reviews_received(restaurant_id)
  reviews_data = RestaurantDB.execute(<<-SQL, restaurant_id)
      SELECT restaurant_reviews.*
        FROM restaurant_reviews
       WHERE restaurant_reviews.restaurant_id = ?
    SQL
    reviews_data.map do |review_data|
      RestaurantReview.new(review_data['review'],
						   review_data['score'],
						   review_data['date'],
						   review_data['critic_id'],
						   review_data['restaurant_id'],
						   review_data['id'])
	end
  end

  def self.reviews_given(critic_id)
    reviews_data = RestaurantDB.execute(<<-SQL, critic_id)
      SELECT restaurant_reviews.*
        FROM restaurant_reviews
       WHERE restaurant_reviews.critic_id = ?
    SQL
    reviews_data.map do |review_data|
      RestaurantReview.new(review_data['review'],
						   review_data['score'],
						   review_data['date'],
						   review_data['critic_id'],
						   review_data['restaurant_id'],
						   review_data['id'])
	end					  
  end

  def self.unreviewed_restaurants(critic_id)
    restaurants_data = RestaurantDB.execute(<<-SQL, critic_id)
      SELECT restaurant_reviews.*
        FROM restaurant_reviews
       WHERE restaurant_id NOT IN (
       		SELECT restaurant_id
       		  FROM restaurant_reviews
       		 WHERE critic_id = ?
    	)
    SQL
    restaurants_data.map do |restaurant_data|
      Restaurant.new(restaurant_data['name'],
      				 restaurant_data['neighborhood'], 
      				 restaurant_data['cuisine'],
      				 restaurant_data['id']) 
	end	
  end

  def self.average_score_given(critic_id)
    return 0.0 if critic_id.nil?
    RestaurantDB.execute(<<-SQL, critic_id)[0]['avg_score']
	  SELECT AVG(score) AS avg_score
      FROM (
      	SELECT score
      	  FROM restaurant_reviews
      	 WHERE restaurant_reviews.critic_id = ?
      )
	SQL
  end

  def self.average_score_received(restaurant_id)
    return 0.0 if restaurant_id.nil?
    RestaurantDB.execute(<<-SQL, restaurant_id)[0]['avg_score']
	  SELECT AVG(score) AS avg_score
      FROM (
      	SELECT score
      	  FROM restaurant_reviews
      	 WHERE restaurant_reviews.restaurant_id = ?
      )
	SQL
  end
  	
# Use reviews of restaurants when the chef was head chef there
  def self.reviews(chef_id)
    reviews_data = RestaurantDB.execute(<<-SQL, chef_id)
      SELECT restaurant_reviews.*
        FROM restaurant_reviews
        JOIN chef_tenures
          ON restaurant_reviews.restaurant_id = chef_tenures.restaurants_id
       WHERE chef_tenures.chef_id = ?
         AND chef_tenures.is_head_chef = 1
         AND restaurant_reviews.date BETWEEN chef_tenures.start_date AND chef_tenures.end_date
    SQL

    reviews_data.map do |review_data|
      RestaurantReview.new(review_data['review'],
						   review_data['score'],
						   review_data['date'],
						   review_data['critic_id'],
						   review_data['restaurant_id'],
						   review_data['id'])
	end	
  end

  attr_reader :id
  attr_accessor :review, :score, :date, :critic_id, :restaurant_id

  def initialize(review, score, date, critic_id, restaurant_id,id=nil)
    @review = review
    @score = score
    @date = date
    @critic_id = critic_id
    @restaurant_id = restaurant_id
    @id = id
  end  
end

