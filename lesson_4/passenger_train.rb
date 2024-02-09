require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end

  private

  def carriage_compatible?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end