require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  private

  def carriage_compatible?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end