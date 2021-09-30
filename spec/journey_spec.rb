require "Journey"

describe Journey do
  let(:station) { double "station", :name => "Victoria" }

  describe "#touch_in" do
    it "remembers the station you started journey from" do
      subject.set_entry_station(station.name)
      expect(subject.entry_station).to eq station.name
    end
  end

  it "returns false if oyster is not in journey" do
    expect(subject.in_journey?).to eq false
  end

  describe "#touch_in" do
    let(:oystercard) { double "oystercard", :touch_out => subject.set_exit_station(station) }
    it "forgets the entry station on touch out" do
      subject.set_entry_station(station.name)
      oystercard.touch_out(station)
      expect(subject.entry_station).to eq nil
    end
  end

  # it "stores exit station" do
  #   expect(subject.exit_station).to eq exit_station
  # end

  # describe "#in_journey?" do
  #   it "oyster card is initially not in journey" do
  #     expect(subject.in_journey?).to eq false
  #   end
  # end

  # describe "#list_of_journeys" do
  #   it "stores a list of previous journeys" do
  #     expect(subject.list_of_journeys).to be_truthy
  #   end

  #   it "is empty by default" do
  #     expect(subject.list_of_journeys).to be_empty
  #   end
  # end
end
