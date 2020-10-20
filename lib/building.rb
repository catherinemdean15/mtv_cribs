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



end
