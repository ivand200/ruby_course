class Train
  attr_reader :number, :type, :carriages, :speed

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
  end

  def speed_up(amount)
    @speed += amount
  end

  def brake
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if speed == 0 && carriage_compitable?(carriage)
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

  protected

  # These methods are protected because they are intended to be used internally by the class and its subclasses.
  # External methods, objects should not directly manipulate train within a route.

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.size - 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  private

  # This method is private because it's an internal check to ensure that only compatible carriages added to the train.
  # External methods, objects should not be concerned with internal logic of compatibility.

  def carriage_compatible?(carriage)
    carriage.type == @type
  end
end


class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end

  private

  def carriage_compatible?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end


class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

    private

    def carriage_compatible?(carriage)
      carriage.is_a?(CargoCarriage)
    end
end


class PassengerCarriage
  attr_reader :type

  def initialize
    @type = :passenger
  end
end


class CargoCarriage
  attr_reader :type

  def initialize
    @type = :cargo
  end
end

