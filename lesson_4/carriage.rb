require_relative 'validate'
require_relative 'manufacturer'

class Carriage
  include Manufacturer
  include Validate

  attr_reader :type, :total_place, :used_place

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
    validate!
  end

  def free_space
    total_place - used_place
  end

  protected

  def validate!
    raise "Carriage type cannot be nil" if type.nil?
  end
end