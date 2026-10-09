class Owner
  attr_reader :name, :stays

  def initialize(name)
    @name = name
    @stays = []
  end

  def add_stay(arg)
    @stays << arg
  end

  # Move to Invoice class
  def invoice
    inv = Invoice.new(name, stays)
    inv.result
  end
end
