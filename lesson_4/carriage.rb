class Carriage
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Carriage type cannot be nil" if type.nil?
  end
end