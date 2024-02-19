# frozen_string_literal: true

require_relative 'route'

class RouteManager
  def initialize(routes, stations)
    @routes = routes
    @stations = stations
  end

  def create_route(start_station_name, end_station_name)
    start_station = find_station_by_name(start_station_name)
    end_station = find_station_by_name(end_station_name)

    raise 'Start and end stations must be different' if start_station == end_station
    raise 'Start station cannot be nil' if start_station.nil?
    raise 'End station cannot be nil' if end_station.nil?

    route = Route.new(start_station, end_station)
    @routes << route
    puts "Route from #{start_station.name} to #{end_station.name} created."
  rescue RuntimeError => e
    puts "Error creating route: #{e.message}"
    nil
  end

  def add_station_to_route(route, station_name)
    station = find_station_by_name(station_name)

    if route.nil? || station.nil?
      puts 'Route or station not found.'
      return
    end

    if route.stations.include?(station)
      puts 'Station already in the route.'
    else
      route.add_station(station)
      puts "Stations #{station.name} added to the route."
    end
  end

  def remove_station_from_route(route_id, station_name)
    route = @routes[route_id]
    station = find_station_by_name(station_name)

    if route.nil? || station.nil?
      puts 'Route or station not found.'
      return
    end

    if route.stations.include?(station) && route.stations.first != station && route.stations.last != station
      route.remove_station(station)
      puts "Station #{station.name} removed from route."
    else
      puts 'Station cannot be removed.'
    end
  end

  private

  def find_station_by_name(name)
    @stations.find { |station| station.name == name }
  end
end
