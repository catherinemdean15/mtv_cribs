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
    @unit3 = Apartment.new({number: "C3",
                           monthly_rent: 1150,
                           bathrooms: 2,
                           bedrooms: 2
                           })
    @unit4 = Apartment.new({number: "D4",
                           monthly_rent: 1500,
                           bathrooms: 2,
                           bedrooms: 3
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
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @unit1.add_renter(@renter1)
    @unit2.add_renter(@renter2)
    assert_equal ["Aurora", "Tim"], @building.renters
  end

  def test_average_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    assert_equal 1099.5, @building.average_rent
  end

  def test_rented_units
    renter1 = Renter.new("Spencer")
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    assert_equal [], @building.rented_units

    @unit2.add_renter(renter1)

    assert_equal [@unit2], @building.rented_units
  end

  def test_renter_with_highest_rent
    renter1 = Renter.new("Spencer")
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(renter1)

    assert_equal renter1, @building.renter_with_highest_rent

    renter2 = Renter.new("Jessie")
    @unit1.add_renter(renter2)

    assert_equal renter2, @building.renter_with_highest_rent

    renter3 = Renter.new("Max")
    @unit3.add_renter(renter3)

    assert_equal renter2, @building.renter_with_highest_rent
  end

  def test_units_by_number_of_bedrooms
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @building.add_unit(@unit4)
    hash = {
            3 => ["D4"],
            2 => ["B2", "C3"],
            1 => ["A1"],
    }
    assert_equal hash, @building.units_by_number_of_bedrooms
  end

  def test_annual_breakdown
    renter1 = Renter.new("Spencer")
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(renter1)
    hash = {
            "Spencer" => 11988
    }
    assert_equal hash, @building.annual_breakdown

    renter2 = Renter.new("Jessie")
    @unit1.add_renter(renter2)
    hash2 = {
            "Spencer" => 11988,
            "Jessie" => 14400
    }
  end

  def test_rooms_by_renter
    renter1 = Renter.new("Spencer")
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(renter1)
    renter2 = Renter.new("Jessie")
    @unit1.add_renter(renter2)
    hash = {
           renter2 => {bathrooms: @unit1.bathrooms,
                       bedrooms: @unit1.bedrooms
           },
           renter1 => {bathrooms: @unit2.bathrooms,
                       bedrooms: @unit2.bedrooms,
           }
    }
    assert_equal hash, @building.rooms_by_renter
  end
end
