# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  validate :type, :presence
  validate :type, :type, Symbol
  def initialize(total_place)
    @type = :cargo
    super(total_place)
  end

  def occupy_volume(volume)
    raise 'Not enough available volume' if volume > free_space

    @used_place += volume
  end
end

