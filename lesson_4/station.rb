# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'
require_relative 'validation'
require_relative 'accessor'
class Station
  include InstanceCounter
  include Validation
  include Accessors

  @@stations = []
  attr_accessor_with_history :name
  attr_reader :trains

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
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

  def each_train(&block)
    trains.each(&block)
  end
end
