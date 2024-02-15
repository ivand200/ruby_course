require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :total_volume, :occupied_volume
  def initialize(total_volume)
    @type = :cargo
    @total_volume = total_volume
    @occupied_volume = 0
  end

  def occupy_volume(volume)
    raise "Not enough available volume" if volume > available_volume
    @occupied_volume += volume
  end

  def available_volume
    total_volume - occupied_volume
  end
end