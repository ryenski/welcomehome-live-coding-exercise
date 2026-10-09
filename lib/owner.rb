class Owner
  attr_reader :name, :stays

  def initialize(name)
    @name = name
    @stays = []
  end

  def add_stay(arg)
    @stays << arg
  end

  def invoice
    inv = Invoice.new(name, stays)
    inv.result
  end

  def html_invoice
    inv = Invoice.new(name, stays)
    inv.result('html')
  end
end
