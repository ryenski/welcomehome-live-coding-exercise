class Stay
  attr_reader :pet, :nights

  def initialize(pet, nights)
    @pet = pet
    @nights = nights
  end

  def amount
    # determine amounts for each line
    this_amount = 0

    case pet.price_code
    when Pet::DOG
      this_amount += 20
      this_amount += (nights - 2) * 12.5 if nights > 2

    when Pet::EXOTIC
      this_amount += nights * 25
    when Pet::FISH
      this_amount += 7.5
      this_amount += (nights - 3) * 2.5 if nights > 3
    end
    this_amount
  end
end
