class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_ty(type)
    @trains.count { |train| train.type == type }
  end
end


class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @station = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) && station != @stations.first && station != @stations.last
  end

  def list_stations
    @stations.each { |station| puts station.name}
  end
end


class Train
  attr_reader :number, :type, :carriages, :speed

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def speed_up(amount)
    @speed += amount
  end

  def brake
    @speed = 0
  end

  def add_carriage
    @carriages += 1 if @speed == 0
  end

  def remove_carriage
    @carriages -= 1 if @speed == 0 && @carriages > 0
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

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.size - 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index > 0
  end
end