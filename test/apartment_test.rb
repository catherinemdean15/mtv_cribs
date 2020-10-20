require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment.rb'

class ApartmentTest < Minitest::Test

  def setup
    @unit1 = Apartment.new({number: "A1",
                           monthly_rent: 1200,
                           bathrooms: 1,
                           bedrooms: 1
                           })
  end

  def test_it_exists
    assert_instance_of Apartment, @unit1
  end

  def test_it_calls_number
    assert_equal "A1", @unit1.number
  end
  
end
