require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'cargo_train'

class MainInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def run
    loop do
      puts "\nPlease choose an action:"
      puts "1: Create station"
      puts "2: Create train"
      puts "3: Create or manage routes"
      puts "4: Assign a route to a train"
      puts "5: Add carriage to a train"
      puts "6: Remove carriage from a train"
      puts "7: Move train along the route"
      puts "8: List stations and trains at the station"
      puts "9: Exit"
      print "> "
      choice = gets.chomp.to_i
      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then manage_route
      when 4 then assign_route
      when 5 then add_carriage
      when 6 then remove_carriage
      when 7 then move_train
      when 8 then list_stations_and_trains
      when 9 then break
      else
        puts "Invalid option. Please enter a number from 1 to 9."
      end
    end
  end

  private

  def create_station
    print "Enter station name: "
    name = gets.chomp
    @stations << Station.new(name)
    puts "Station '#{name}' created."
  end

  def create_train
    print "Enter train number: "
    number = gets.chomp
    print "Enter train type (passenger/cargo): "
    type = gets.chomp.downcase
    if type == "passenger"
      @trains << PassengerTrain.new(number)
      puts "Passenger train #{number} created."
    elsif type == "cargo"
      @trains << CargoTrain.new(number)
      puts "Cargo train #{number} created."
    else
      puts "Invalid train type. Please enter 'passenger' or 'cargo'."
    end
  end

  def manage_route
    puts "1: Create new route"
    puts "2: Add station to existing route"
    puts "3: Remove station from existing route"
    print "> "
    choice = gets.chomp.to_i
    case choice
    when 1 then create_route
    when 2 then add_station_to_route
    when 3 then remove_station_from_route
    else
      puts "Invalid option."
    end
  end

  def create_route
    puts "Enter the start station name:"
    start_station = select_station
    puts "Enter the end station name:"
    end_station = select_station
    return if start_station.nil? || end_station.nil? || start_station == end_station

    @routes << Route.new(start_station, end_station)
    puts @routes
    puts "Route from #{start_station.name} to #{end_station.name} created."
  end

  def add_station_to_route
    route = select_route
    return if route.nil?

    station = select_station
    return if station.nil?

    if route.stations.include?(station)
      puts "Station already in the route."
    else
      route.add_station(station)
      puts "Station #{station.name} added to the route."
    end
  end

  def remove_station_from_route
    route = select_route
    return if route.nil?

    station = select_station
    return if station.nil?

    if route.stations.include?(station)
      route.remove_station(station)
      puts "Station #{station.name} removed from route."
    else
      puts "Station is not in the route."
    end
  end

  def assign_route
    train = select_train
    return if train.nil?

    route = select_route
    return if route.nil?

    train.assign_route(route)
    puts "Route assigned to train #{train.number}"
  end

  def add_carriage
    train = select_train
    return if train.nil?

    if train.type == :passenger
      train.add_carriage(PassengerCarriage.new)
      puts "Passenger carriage added."
    elsif train.type == :cargo
      train.add_carriage(CargoCarriage.new)
      puts "Cargo carriage added."
    end
  end

  def remove_carriage
    train = select_train
    return if train.nil? || train.carriages.empty?

    train.remove_carriage(train.carriages.last)
    puts "Carriage removed from train #{train.number}."
  end

  def move_train
    train = select_train
    return if train.nil?

    puts "1: Move forward"
    puts "2: Move: backward"
    print "> "
    choice = gets.chomp.to_i
    case choice
    when 1
      train.move_forward
      puts "Train moved forward to #{train.current_station.name}"
    when 2
      train.move_backward
      puts "Train moved backward to #{train.current_station.name}"
    else
      puts "Invalid option"
    end
  end

  def list_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.name}"
      station.trains.each { |train| puts " Train Number: #{train.number}, Type: #{train.type}, Carriages: #{train.carriages.count}" }
    end
  end

  def select_station
    puts "Available stations:"
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
    print "Select station by number: "
    index = gets.chomp.to_i - 1
    @stations[index]
  end

  def select_route
    puts "Available routes:"
    # @routes.each_with_index { |route, index| puts "#{index + 1}: Route ##{route.stations}" }
    @routes.each_with_index do |route, index|
      start_station_name = route.stations.first.name
      end_station_name = route.stations.last.name
      puts "#{index + 1}: Route from #{start_station_name} to #{end_station_name}"
    end
    print "Select route by number: "
    index = gets.chomp.to_i - 1
    @routes[index]
  end

  def select_train
    puts "Available trains."
    @trains.each_with_index { |train, index| puts "#{index + 1}: #{train.number}" }
    print "Select train by number: "
    index = gets.chomp.to_i - 1
    @trains[index]
  end
end

interface = MainInterface.new
interface.run