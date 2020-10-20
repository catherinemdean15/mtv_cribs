require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'

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

  def test_it_calls_monthly_rent
    assert_equal 1200, @unit1.monthly_rent
  end

  def test_it_calls_bathrooms
    assert_equal 1, @unit1.bathrooms
  end

  def test_it_calls_bedrooms
    assert_equal 1, @unit1.bedrooms
  end

  def test_it_calls_renter_when_no_renter
    assert_equal nil, @unit1.renter
  end

  def test_it_calls_renter_when_renter
    @unit1.add_renter(@renter1)
    assert_equal @renter1, @unit1.renter
  end

end
