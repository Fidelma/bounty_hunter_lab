
require('pg')

class Bounty
  attr_accessor :name, :species, :bounty_value, :home_world
  attr_reader :id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @species = details['species']
    @bounty_value = details['bounty_value']
    @home_world = details['home_world']
  end

  def save()
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = "INSERT INTO bounties (name, species, bounty_value, home_world)
    VALUES($1, $2, $3, $4)
    RETURNING id;"
    db.prepare('save', sql)
    values = [@name, @species, @bounty_value, @home_world]
    bounty = db.exec_prepared('save', values)
    @id = bounty.first['id']
    db.close
  end

  def update()
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = "UPDATE bounties
          SET (name, species, bounty_value, home_world)
          =($1, $2, $3, $4)
          WHERE id = $5;"
    values = [@name, @species, @bounty_value, @home_world, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close
  end

  def self.delete_all()
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = "DELETE FROM bounties;"
    db.prepare('delete_all', sql)
    db.exec_prepared('delete_all')
    db.close
  end

  def self.all()
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = "SELECT * FROM bounties;"
    db.prepare('all', sql)
    bounties = db.exec_prepared('all')
    db.close
    return bounties.map { |bounty| Bounty.new(bounty)}
  end

  def self.delete(id)
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = "DELETE FROM bounties
          WHERE id = $1;"
    values = [id]
    db.prepare('delete', sql)
    db.exec_prepared('delete', values)
    db.close
  end


  def self.find_by_name(name)
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = 'SELECT * FROM bounties
           WHERE name = $1;'
    values = [name]
    db.prepare( 'find_by_name', sql)
    bounty = db.exec_prepared('find_by_name', values)
    db.close
    bounty_hash = bounty[0]
    return Bounty.new(bounty_hash)
  end
end
