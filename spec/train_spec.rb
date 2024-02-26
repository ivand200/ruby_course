require 'rspec'
require_relative '../lesson_4/train'
require_relative '../lesson_4/carriage'
require_relative '../lesson_4/passenger_train'
require_relative '../lesson_4/cargo_train'


RSpec.describe 'Train Tests' do
  context 'Validation module' do
    it 'validates presence of number for PassengerTrain' do
      expect { PassengerTrain.new(nil) }.to raise_error('Value cannot be nil or empty')
    end

    it 'validates format of number for CargoTrain' do
      expect { CargoTrain.new('invalid_number') }.to raise_error('Value does not match format')
    end

    it 'allows valid train numbers' do
      expect { PassengerTrain.new('123-ab') }.not_to raise_error
    end
  end

  context 'Accessors module' do
    before :each do
      @train = PassengerTrain.new('123-ab')
    end

    it 'tracks changes to speed with history' do
      @train.speed = 10
      @train.speed = 20
      @train.speed = 30
      puts @train.speed
      expect(@train.speed_history).to eq([0, 10, 20])
    end

    it 'enforces strong typing on type attribute' do
      expect { @train.type = 'not a symbol' }.to raise_error(TypeError)
    end
  end
end