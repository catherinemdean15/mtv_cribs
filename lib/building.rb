class Building
  attr_reader :units


  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    all_renters = []
    @units.map do |unit|
      all_renters << unit.renter.name
    end
    all_renters
  end

  def average_rent
    average_rent = 0
    @units.map do |unit|
      average_rent += unit.monthly_rent
    end
    average_rent.to_f/@units.count
  end

  def rented_units
    rented_units = []
    @units.each do |unit|
      if unit.renter != nil
        rented_units << unit
      end
    end
    rented_units
  end

  def renter_with_highest_rent
    high_rent = 0
    renter = nil
    rented_units.each do |unit|
      if unit.monthly_rent > high_rent
        high_rent = unit.monthly_rent
        renter = unit.renter
      end
    end
    renter
  end

  def units_by_number_of_bedrooms
    units_by_bedroom = {
            3 => [],
            2 => [],
            1 => [],
    }
    @units.each do |unit|
      units_by_bedroom[unit.bedrooms] << unit.number
    end
    units_by_bedroom
  end

  def annual_breakdown
    breakdown = Hash.new
    rented_units.each do |unit|
      breakdown[unit.renter.name] = unit.monthly_rent*12
    end
    breakdown
  end

  def rooms_by_renter
    rooms = Hash.new
    rented_units.each do |unit|
      rooms[unit.renter] = {bathrooms: unit.bathrooms,
                            bedrooms: unit.bedrooms
                            }
    end
    rooms
  end

end
