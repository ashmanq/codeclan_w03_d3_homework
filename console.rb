require_relative('models/property')
require('pry-byebug')


property1 = Property.new({
              'address' => '1 Frozen Road, The North Pole',
              'value' => 1000000.00,
              'year_built' => 280,
              'no_of_bedrooms'=> 100
              })

property2 = Property.new({
              'address' => '721–725 Fifth Avenue, New York',
              'value' => 300000000.00,
              'year_built' => 1983,
              'no_of_bedrooms'=> 2000
              })

Property.delete_all()

property1.save()
property1.value = 1
property1.update()

property2.save()
property2.delete()

properties = Property.all()

binding.pry
nil
