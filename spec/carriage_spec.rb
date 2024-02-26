require 'rspec'
require_relative '../lesson_4/carriage'
require_relative '../lesson_4/passenger_carriage'
require_relative '../lesson_4/cargo_carriage'


RSpec.describe PassengerCarriage do
  before(:each) do
    @carriage = PassengerCarriage.new(20) # assuming 20 is the total_place for this test
  end

  context 'initialization and type validation' do
    it 'sets the correct type' do
      expect(@carriage.type).to eq(:passenger)
    end

    it 'validates the type is a Symbol' do
      expect(@carriage.type).to be_a(Symbol)
    end
  end

  context 'occupying seats' do
    it 'occupies a seat and reduces free space' do
      expect { @carriage.occupy_seat }.to change { @carriage.free_space }.by(-1)
    end

    it 'raises an error when all seats are occupied' do
      20.times { @carriage.occupy_seat }
      expect { @carriage.occupy_seat }.to raise_error('All seats are occupied')
    end
  end
end

RSpec.describe CargoCarriage do
  before(:each) do
    @carriage = CargoCarriage.new(100) # assuming 100 is the total_place for this test
  end

  context 'initialization and type validation' do
    it 'sets the correct type' do
      expect(@carriage.type).to eq(:cargo)
    end

    it 'validates the type is a Symbol' do
      expect(@carriage.type).to be_a(Symbol)
    end
  end

  context 'occupying volume' do
    it 'occupies volume and reduces free space' do
      expect { @carriage.occupy_volume(50) }.to change { @carriage.free_space }.from(100).to(50)
    end

    it 'raises an error when the volume exceeds free space' do
      expect { @carriage.occupy_volume(101) }.to raise_error('Not enough available volume')
    end
  end
end