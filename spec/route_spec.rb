require 'rspec'
require_relative '../lesson_4/route'

RSpec.describe Route do
  let(:start_station) { double('Station', name: 'Start') }
  let(:end_station) { double('Station', name: 'End') }
  let(:middle_station) { double('Station', name: 'Middle') }

  before(:each) do
    @route = Route.new(start_station, end_station)
  end

  context 'initialization and validation' do
    it 'initializes with start and end stations' do
      expect(@route.stations).to eq([start_station, end_station])
    end

    it 'validates stations are an Array' do
      expect(@route.stations).to be_a(Array)
    end
  end

  context 'modifying the route' do
    it 'can add a station' do
      @route.add_station(middle_station)
      expect(@route.stations[1]).to eq(middle_station)
    end

    it 'can remove a station' do
      @route.add_station(middle_station)
      @route.remove_station(middle_station)
      expect(@route.stations).not_to include(middle_station)
    end
  end
end