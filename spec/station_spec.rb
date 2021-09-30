require "station"
describe Station do
  let(:station) { double("Piccadily") }
  let(:zone) { double (1) }
  describe "#initialize" do
    before(:each) do
      @station_instance = Station.new(station, zone)
    end

    it "initializes with a name" do
      expect(@station_instance.name).to eq station
    end

    it "initializes with a zone" do
      expect(@station_instance.zone).to eq zone
    end
  end
end
