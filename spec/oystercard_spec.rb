require "oystercard"

RSpec.describe OysterCard do
  let(:entry_station) { double("Paddington") }
  let(:exit_station) { double("Liverpool street") }

  describe "#initialize" do
    it "creates each oystercard instance with a default balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "allows oyster card to be topped up" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "raises error if balance is higher than 90" do
      maximum = OysterCard::MAX_LIMIT
      expect { subject.top_up(91) }.to raise_error "Limit exceeded: £#{maximum}! Cannot top up"
    end
  end

  describe "#touch_in" do
    before(:each) do
      subject.top_up(5)
      subject.touch_in(entry_station)
    end

    it "can touch in" do
      expect(subject.in_journey?).to be_truthy
    end

    it "raises an error if oyster has insufficient funds" do
      card = OysterCard.new
      expect { card.touch_in(entry_station) }.to raise_error "Insufficient funds, you need at least £#{OysterCard::MIN_LIMIT} to touch in"
    end

    it "remembers the station you started journey from" do
      expect(subject.entry_station).to eq entry_station
    end

    it "stores the entry_station" do
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe "#touch_out(exit_station)" do
    before(:each) do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it "returns false if oyster is not in journey" do
      expect(subject.in_journey?).to eq false
    end

    it "deducts the cost of the journey from the card when touching out" do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-OysterCard::MIN_CHARGE)
    end

    it "forgets the entry station on touch out" do
      expect(subject.entry_station).to eq nil
    end

    it "stores exit station" do
      expect(subject.exit_station).to eq exit_station
    end

    it "creates a journey when you touch out" do
      expect(subject.journey.values).to eq [entry_station, exit_station]
    end
  end

  describe "#in_journey?" do
    it "oyster card is initially not in journey" do
      expect(subject.in_journey?).to eq false
    end
  end

  describe "#list_of_journeys" do
    it "stores a list of previous journeys" do
      expect(subject.list_of_journeys).to be_truthy
    end

    it "is empty by default" do
      expect(subject.list_of_journeys).to be_empty
    end
  end
end
