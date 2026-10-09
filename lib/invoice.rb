class Invoice
  def initialize(name, stays = [])
    @name = name
    @stays = stays
  end
  attr_reader :name, :stays

  def result(format = 'text')
    formatter = formater_for(format)
    total_amount = 0
    treat_points = 0

    result = formatter.header(name)

    result += formatter.wrapper('ul') do
      @stays.collect do |stay|
        this_amount = stay.amount

        # add treat points
        treat_points += 1
        # add bonus for an exotic stay of three nights or more
        # TODO: consider moving  to invoice as a calculatoin
        treat_points += 1 if stay.pet.price_code == Pet::EXOTIC && stay.nights > 2
        # show figures for this stay
        # TODO: Consider create factory object for text/html output

        total_amount += this_amount

        formatter.stay_line(stay.pet.name, this_amount)
      end.join
    end

    # add footer lines
    result += formatter.amount_owed(total_amount)
    result += formatter.treat_points(treat_points)
    # TODO: Add wrapper method
    result
  end

  def formater_for(format)
    case format
    when 'text'
      TextFormatter.new
    when 'html'
      HtmlFormatter.new
    end
  end

  class HtmlFormatter
    def header(name)
      "<div><h1>Pet Hotel invoice for #{name}</h1>"
    end

    def stay_line(pet_name, amount)
      "<li>#{pet_name}: #{amount}</li>"
    end

    def amount_owed(total_amount)
      "<p>Amount owed is #{total_amount}</p>"
    end

    def treat_points(treat_points)
      "<p>You earned #{treat_points} treat points</p></div>"
    end

    def wrapper(tag, &block)
      str = block.call
      str.empty? ? str : "<#{tag}>#{str}</#{tag}>"
    end
  end

  class TextFormatter
    def header(name)
      "Pet Hotel invoice for #{name}\n"
    end

    def stay_line(pet_name, amount)
      "\t" + pet_name + "\t" + amount.to_s + "\n"
    end

    def amount_owed(total_amount)
      "Amount owed is #{total_amount}\n"
    end

    def treat_points(treat_points)
      "You earned #{treat_points} treat points"
    end

    def wrapper(_tag, &block)
      yield
    end
  end
end
