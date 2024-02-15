require_relative 'validate'
require_relative 'manufacturer'

class Carriage
  include Manufacturer
  include Validate

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise "Carriage type cannot be nil" if type.nil?
  end
end