require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validate'

class Train
  include Manufacturer
  include InstanceCounter
  include Validate

  attr_reader :number, :type, :carriages, :speed

  VALID_NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@trains = {}
  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def speed_up(amount)
    @speed += amount
  end

  def brake
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if speed == 0 && carriage_compatible?(carriage)
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if speed == 0
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

  def move_forward
    if next_station
      current_station.send_train(self)
      @current_station_index += 1
      current_station.accept_train(self)
    end
  end

  def move_backward
    if previous_station
      current_station.send_train(self)
      @current_station_index -= 1
      current_station.accept_train(self)
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def self.find(number)
    @@trains[number]
  end

  def each_carriage
    carriages.each { |carriage| yield(carriage) }
  end

  protected

  # These methods are protected because they are intended to be used internally by the class and its subclasses.
  # External methods, objects should not directly manipulate train within a route.

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.size - 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def validate!
    raise "Number can't be nil" if number.nil?
    raise "Number has invalid format" if number !~ VALID_NUMBER_FORMAT
  end

  private

  # This method is private because it's an internal check to ensure that only compatible carriages added to the train.
  # External methods, objects should not be concerned with internal logic of compatibility.

  def carriage_compatible?(carriage)
    carriage.type == @type
  end
end




