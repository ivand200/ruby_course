require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :total_place, :used_place
  def initialize(total_place)
    @type = :cargo
    super
  end

  def occupy_volume(volume)
    raise "Not enough available volume" if volume > free_space
    @used_place += volume
  end
end
