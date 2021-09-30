class OysterCard 
  attr_reader :balance, :entry_station, :list_of_journeys, :exit_station, :journey

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @list_of_journeys = []
    @journey = {}
  end

  def top_up(value)
    fail "Limit exceeded: £#{MAX_LIMIT}! Cannot top up" if value > MAX_LIMIT
    @balance += value
  end

  def touch_in(entry_station)
    fail "Insufficient funds, you need at least £#{MIN_LIMIT} to touch in" if @balance < MIN_LIMIT
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_CHARGE)
    @exit_station = exit_station
    @journey = {"entry station": entry_station, "exit station": exit_station}
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil 
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
