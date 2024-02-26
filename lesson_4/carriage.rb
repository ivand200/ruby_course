# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validation'
require_relative 'accessor'

class Carriage
  include Manufacturer
  include Validation
  include Accessors

  validate :total_place, :presence
  validate :total_place, :type, Integer

  attr_accessor_with_history :total_place, :used_place
  attr_accessor :type


  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
    @type = type
    validate!
  end

  def free_space
    total_place - used_place
  end
end
