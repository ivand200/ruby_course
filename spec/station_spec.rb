require_relative '../lesson_4/station'

RSpec.describe Station do
  context 'Initialization and validation' do
    it 'creates a station with a valid name' do
      station = Station.new('Grand Central')
      expect(station.name).to eq('Grand Central')
    end

    it 'fails to create a station with an empty name' do
      expect { Station.new('') }.to raise_error(RuntimeError, 'Value cannot be nil or empty')
    end
  end

  context 'Accessors module' do
    before(:each) do
      @station = Station.new('Initial Name')
    end

    it 'tracks changes to name with history' do
      @station.name = 'New Name'
      expect(@station.name_history).to include('Initial Name')
    end
  end

  context 'Handling trains' do
    before(:each) do
      @station = Station.new('Busy Junction')
      @train1 = double('Train', type: :cargo)
      @train2 = double('Train', type: :passenger)
    end

    it 'accepts trains' do
      @station.accept_train(@train1)
      @station.accept_train(@train2)
      expect(@station.trains.count).to eq(2)
    end

    it 'sends trains' do
      @station.accept_train(@train1)
      @station.send_train(@train1)
      expect(@station.trains).not_to include(@train1)
    end

    it 'filters trains by type' do
      @station.accept_train(@train1)
      @station.accept_train(@train2)
      expect(@station.trains_by_type(:cargo)).to eq(1)
      expect(@station.trains_by_type(:passenger)).to eq(1)
    end
  end

  context 'Iterating over trains' do
    it 'yields each train to a block' do
      station = Station.new('Iteration Central')
      train1 = double('Train')
      train2 = double('Train')
      station.accept_train(train1)
      station.accept_train(train2)

      expect { |b| station.each_train(&b) }.to yield_successive_args(train1, train2)
    end
  end
end