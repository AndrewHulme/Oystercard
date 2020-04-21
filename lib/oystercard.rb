class Oystercard
  LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    #@in_journey = false
  end

  def top_up(amount)
    @balance + amount <= LIMIT ? @balance += amount : exceeds_balance_error
  end

  def touch_in(entry_station)
    insufficient_balance_error if @balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    touch_out_error if in_journey? == false
    deduct(MIN_FARE)
    @exit_station = exit_station

    hash = {entry: @entry_station, exit: @exit_station}
    @journeys << hash

    @entry_station = nil

  end

  def in_journey?
    @entry_station == nil ? false : true
  end


  private
  def exceeds_balance_error
    raise "Exceeds balance limit of #{LIMIT}"
  end

  def insufficient_balance_error
    raise "Insufficient balance to travel, at least £#{MIN_FARE} needed."
  end

  def touch_out_error
    raise "Card not touched in"
  end

  def deduct(amount)
    @balance -= amount
  end

end
