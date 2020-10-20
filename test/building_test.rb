require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
    @unit1 = Apartment.new({number: "A1",
                           monthly_rent: 1200,
                           bathrooms: 1,
                           bedrooms: 1
                           })
    @unit2 = Apartment.new({number: "B2",
                            monthly_rent: 999,
                            bathrooms: 2,
                            bedrooms: 2
                            })
    @renter1 = Renter.new("Aurora")
    @renter2 = Renter.new("Tim")
  end

  def test_it_exists
    assert_instance_of Building, @building
  end

  def test_it_calls_units_with_no_units
    assert_equal [], @building.units
  end

  def test_it_calls_units_when_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    assert_equal [@unit1, @unit2], @building.units
  end

  def test_it_calls_renters_with_no_renters
    assert_equal [], @building.renters
  end

  def test_it_calls_renter_when_renter
    @unit1.add_renter(@renter1)
    @unit2.add_renter(@renter2)
    assert_equal [@renter1, @renter2], @building.renters
  end

end
