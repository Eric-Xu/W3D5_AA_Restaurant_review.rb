require_relative 'restaurant_db'
require_relative 'chef'
require_relative 'restaurant'

class ChefTenures	
# Those chefs who worked with this one at the same 
# restaurant at the same time.

  def self.co_workers(chef_id)
	chefs_data = RestaurantDB.execute(<<-SQL, chef_id)
	  SELECT their_tenure.chef_id 
	    FROM chef_tenures my_tenure
	    JOIN chef_tenures their_tenure
	      ON my_tenure.restaurants_id = their_tenure.restaurants_id
	   WHERE my_tenure.chef_id = ?
		 AND (their_tenure.start_date <= my_tenure.end_date)
		 AND (their_tenure.end_date >= my_tenure.start_date)
		 AND my_tenure.chef_id != their_tenure.chef_id
	SQL
  end
end