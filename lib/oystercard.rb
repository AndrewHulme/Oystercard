class Oystercard
  LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance
  attr_reader :in_journey

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    @balance + amount <= LIMIT ? @balance += amount : exceeds_balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @balance >= MIN_FARE ? @in_journey = true : insufficient_balance
  end

  def touch_out
    @in_journey = false
    deduct(MIN_FARE)
  end

  private
  def exceeds_balance
    raise "Exceeds balance limit of #{LIMIT}"
  end

  def insufficient_balance
    raise "Insufficient balance to travel, at least £#{MIN_FARE} needed."
  end

end
