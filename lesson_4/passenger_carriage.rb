# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  validate :type, :presence
  validate :type, :type, Symbol
  def initialize(total_place)
    @type = :passenger
    super(total_place)
  end

  def occupy_seat
    raise 'All seats are occupied' if used_place >= total_place

    @used_place += 1
  end
end
