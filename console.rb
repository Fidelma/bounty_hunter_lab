require('pry')

require_relative('./models/bounty.rb')



bounty1 = Bounty.new({
'name' => 'Bob',
'species' => 'Human',
'bounty_value' => 500,
'home_world' => 'Mars'
  })

  bounty1.bounty_value = 300
  bounty1.update()

  # bounty1.save()
binding.pry
nil
