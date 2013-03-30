require 'singleton'
require 'sqlite3'

class RestaurantDB < SQLite3::Database
  include Singleton

  def initialize
    super("restaurant.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  # taking a page out of Ned's book here
  def self.execute(*args)
    self.instance.execute(*args)
  end
end