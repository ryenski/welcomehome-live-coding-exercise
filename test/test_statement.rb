require "minitest/autorun"
require_relative "../lib/movie"
require_relative "../lib/rental"
require_relative "../lib/customer"

class StatementTest < Minitest::Test
  def statement_for(rentals)
    customer = Customer.new("Martin")
    rentals.each { |r| customer.add_rental(r) }
    customer.statement
  end

  def test_customer_with_no_rentals
    expected = <<~TEXT.chomp
      Rental Record for Martin
      Amount owed is 0
      You earned 0 frequent renter points
    TEXT
    assert_equal expected, statement_for([])
  end

  def test_regular_movie_for_one_day
    rental = Rental.new(Movie.new("Plan 9", Movie::REGULAR), 1)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tPlan 9\t2
      Amount owed is 2
      You earned 1 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_regular_movie_for_two_days_stays_at_flat_rate
    rental = Rental.new(Movie.new("Plan 9", Movie::REGULAR), 2)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tPlan 9\t2
      Amount owed is 2
      You earned 1 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_regular_movie_for_more_than_two_days_adds_surcharge
    rental = Rental.new(Movie.new("Plan 9", Movie::REGULAR), 5)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tPlan 9\t6.5
      Amount owed is 6.5
      You earned 1 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_new_release_for_one_day_earns_no_bonus_point
    rental = Rental.new(Movie.new("Dune", Movie::NEW_RELEASE), 1)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tDune\t3
      Amount owed is 3
      You earned 1 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_new_release_for_more_than_one_day_earns_bonus_point
    rental = Rental.new(Movie.new("Dune", Movie::NEW_RELEASE), 3)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tDune\t9
      Amount owed is 9
      You earned 2 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_childrens_movie_for_three_days_stays_at_flat_rate
    rental = Rental.new(Movie.new("Ratatouille", Movie::CHILDRENS), 3)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tRatatouille\t1.5
      Amount owed is 1.5
      You earned 1 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_childrens_movie_for_more_than_three_days_adds_surcharge
    rental = Rental.new(Movie.new("Ratatouille", Movie::CHILDRENS), 5)
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tRatatouille\t4.5
      Amount owed is 4.5
      You earned 1 frequent renter points
    TEXT
    assert_equal expected, statement_for([rental])
  end

  def test_multiple_rentals_aggregate_totals_and_points
    rentals = [
      Rental.new(Movie.new("Plan 9", Movie::REGULAR), 3),
      Rental.new(Movie.new("Dune", Movie::NEW_RELEASE), 2),
      Rental.new(Movie.new("Ratatouille", Movie::CHILDRENS), 4),
    ]
    expected = <<~TEXT.chomp
      Rental Record for Martin
      \tPlan 9\t3.5
      \tDune\t6
      \tRatatouille\t3.0
      Amount owed is 12.5
      You earned 4 frequent renter points
    TEXT
    assert_equal expected, statement_for(rentals)
  end
end
