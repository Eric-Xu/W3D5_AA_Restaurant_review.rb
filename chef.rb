require_relative 'restaurant_db'
require_relative 'restaurant'
require_relative 'chef_tenures'

class Chef
  def self.find(id)
  	# [ {x, y, z} ]
  	chefs_data = RestaurantDB.execute(<<-SQL, id)
	  SELECT *
        FROM chefs
       WHERE chefs.id = ?
  	SQL

  	chefs_data.empty? ? nil : Chef.new(chefs_data[0]['first_name'],
  									   chefs_data[0]['last_name'], 
  									   chefs_data[0]['mentor_id'], 
  									   chefs_data[0]['id'] )
  end

  attr_reader :id
  attr_accessor :first_name, :last_name, :mentor_id

  def initialize(first_name,last_name, mentor_id,id=nil)
    @first_name = first_name
    @last_name = last_name
    @mentor_id = mentor_id
    @id = id
  end

  def proteges
	chefs_data = RestaurantDB.execute(<<-SQL, self.id)
	  SELECT *
	    FROM chefs
	   WHERE mentor_id = ?
	SQL

	chefs_data.map do |chef_data|
      Restaurant.new(chef_data['first_name'],
      				 chef_data['last_name'], 
      				 chef_data['mentor_id'],
      				 chef_data['id']) 
	end 
  end

  def num_proteges
	RestaurantDB.execute(<<-SQL, self.id)[0]['count']
	  SELECT COUNT(*) AS count
	    FROM chefs
	   WHERE mentor_id = ?
	SQL
  end

  def co_workers
  	ChefTenures.co_workers(self.id)
  end

  def reviews
  	RestaurantReview.reviews(self.id)
  end
end