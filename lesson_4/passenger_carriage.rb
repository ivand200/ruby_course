require_relative 'carriage'

class PassengerCarriage < Carriage

  def initialize(total_place)
    @type = :passenger
    super
  end

  def occupy_seat
    raise "All seats are occupied" if used_place >= total_place
    @used_place += 1
  end
end
