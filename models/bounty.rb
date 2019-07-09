
require('pg')

class Bounty
  attr_accessor :id, :name, :species, :bounty_value, :home_world

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
end
