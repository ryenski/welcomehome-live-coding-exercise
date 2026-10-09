class Invoice
  def initialize(name, stays = [])
    @name = name
    @stays = stays
  end
  attr_reader :name, :stays

  def result
    total_amount = 0
    treat_points = 0
    result = "Pet Hotel invoice for #{@name}\n"
    @stays.each do |element|
      this_amount = 0

      # determine amounts for each line
      # TODO: Consider subclassing type of pet
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
      # TODO: consider moving  to invoice as a calculatoin
      treat_points += 1 if element.pet.price_code == Pet::EXOTIC && element.nights > 2
      # show figures for this stay
      # TODO: Consider create factory object for text/html output
      result += "\t" + element.pet.name + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    # add footer lines
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{treat_points} treat points"
    result
  end
end
