# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end
end

begin
  invalid_train = PassengerTrain.new('abc-66')
rescue StandardError => e
  puts "Validation Error: #{e.message}"
end
