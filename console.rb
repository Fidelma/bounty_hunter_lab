require('pry')

require_relative('./models/bounty.rb')

Bounty.delete_all()

bounty1 = Bounty.new({
'name' => 'Bob',
'species' => 'Human',
'bounty_value' => 500,
'home_world' => 'Mars'
  })


  bounty1.save()

  bounty2 = Bounty.new({
    'name' => 'Harry',
    'species' => 'Weirdo',
    'bounty_value' => 1000,
    'home_world' => 'Earth'
    })

    bounty2.save()

  bounty1.bounty_value = 300
  bounty1.update()

binding.pry
nil
