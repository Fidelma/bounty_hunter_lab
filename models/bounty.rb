class Bounty
  attr_accessor :id, :name, :species, :bounty_value, :home_world

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @species = details['species']
    @bounty_value = details['bounty_value']
    @home_world = details['home_world']
  end 
