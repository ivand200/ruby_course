require_relative 'instance_counter'
class Station
  include InstanceCounter

  @@stations = []
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @@stations
  end

  def accept_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  private

  def validate!
    raise "Station name cannot be empty!" if name.nil? ||name.strip.empty?
  end
end