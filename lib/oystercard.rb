class Oystercard
  LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :in_journey, :entry_station

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    @balance + amount <= LIMIT ? @balance += amount : exceeds_balance_error
  end

  def touch_in(entry_station)
    @balance >= MIN_FARE ? @in_journey = true : insufficient_balance_error
    @entry_station = entry_station
  end

  def touch_out
    @in_journey ? @in_journey = false : touch_out_error
    deduct(MIN_FARE)
    @entry_station = nil
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
