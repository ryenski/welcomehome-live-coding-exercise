class Pet
  DOG = 0
  EXOTIC = 1
  FISH = 2

  attr_reader :name
  attr_accessor :price_code

  def initialize(name, price_code)
    @name = name
    @price_code = price_code
  end
end
