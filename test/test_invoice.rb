require "minitest/autorun"
# To run only specific tests, `gem install minitest-focus`, uncomment the
# line below, and put `focus` on the line above each test you want to run.
# require "minitest/focus"
require_relative "../lib/pet"
require_relative "../lib/stay"
require_relative "../lib/owner"

class String
  # Collapses runs of whitespace (including newlines) into single spaces, so
  # multi-line strings like HTML can be compared without worrying about
  # indentation, e.g. `assert_equal expected.squish, actual.squish`.
  def squish
    gsub(/[[:space:]]+/, " ").strip
  end
end

class InvoiceTest < Minitest::Test
  def invoice_for(stays)
    owner = Owner.new("Sam")
    stays.each { |s| owner.add_stay(s) }
    owner.invoice
  end

  def test_owner_with_no_stays
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      Amount owed is 0
      You earned 0 treat points
    TEXT
    assert_equal expected, invoice_for([])
  end

  def test_dog_for_one_night
    stay = Stay.new(Pet.new("Biscuit", Pet::DOG), 1)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tBiscuit\t20
      Amount owed is 20
      You earned 1 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_dog_for_two_nights_stays_at_flat_rate
    stay = Stay.new(Pet.new("Biscuit", Pet::DOG), 2)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tBiscuit\t20
      Amount owed is 20
      You earned 1 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_dog_for_more_than_two_nights_adds_nightly_charge
    stay = Stay.new(Pet.new("Biscuit", Pet::DOG), 4)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tBiscuit\t45.0
      Amount owed is 45.0
      You earned 1 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_exotic_for_two_nights_earns_no_bonus_point
    stay = Stay.new(Pet.new("Noodle", Pet::EXOTIC), 2)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tNoodle\t50
      Amount owed is 50
      You earned 1 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_exotic_for_more_than_two_nights_earns_bonus_point
    stay = Stay.new(Pet.new("Noodle", Pet::EXOTIC), 3)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tNoodle\t75
      Amount owed is 75
      You earned 2 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_fish_for_three_nights_stays_at_flat_rate
    stay = Stay.new(Pet.new("Bubbles", Pet::FISH), 3)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tBubbles\t7.5
      Amount owed is 7.5
      You earned 1 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_fish_for_more_than_three_nights_adds_nightly_charge
    stay = Stay.new(Pet.new("Bubbles", Pet::FISH), 5)
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tBubbles\t12.5
      Amount owed is 12.5
      You earned 1 treat points
    TEXT
    assert_equal expected, invoice_for([stay])
  end

  def test_multiple_stays_aggregate_totals_and_points
    stays = [
      Stay.new(Pet.new("Biscuit", Pet::DOG), 3),
      Stay.new(Pet.new("Noodle", Pet::EXOTIC), 3),
      Stay.new(Pet.new("Bubbles", Pet::FISH), 4),
    ]
    expected = <<~TEXT.chomp
      Pet Hotel invoice for Sam
      \tBiscuit\t32.5
      \tNoodle\t75
      \tBubbles\t10.0
      Amount owed is 117.5
      You earned 4 treat points
    TEXT
    assert_equal expected, invoice_for(stays)
  end
end
