class Owner
  attr_reader :name

  def initialize(name)
    @name = name
    @stays = []
  end

  def add_stay(arg)
    @stays << arg
  end

  def invoice
    total_amount, treat_points = 0, 0
    result = "Pet Hotel invoice for #{@name}\n"
    @stays.each do |element|
      this_amount = 0

      # determine amounts for each line
      case element.pet.price_code
      when Pet::DOG
        this_amount += 20
        this_amount += (element.nights - 2) * 12.5 if element.nights > 2
      when Pet::EXOTIC
        this_amount += element.nights * 25
      when Pet::FISH
        this_amount += 7.5
        this_amount += (element.nights - 3) * 2.5 if element.nights > 3
      end

      # add treat points
      treat_points += 1
      # add bonus for an exotic stay of three nights or more
      if element.pet.price_code == Pet::EXOTIC && element.nights > 2
        treat_points += 1
      end
      # show figures for this stay
      result += "\t" + element.pet.name + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    # add footer lines
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{treat_points} treat points"
    result
  end
end
