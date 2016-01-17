require 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_customer_can_query_id
    customer = Customer.new(test_helper_customer_one_data)
    assert_equal 1, customer.id
  end

  def test_customer_can_query_first_name
    customer = Customer.new(test_helper_customer_two_data)
    assert_equal "Two", customer.first_name
  end

  def test_customer_can_query_last_name
    customer = Customer.new(test_helper_customer_three_data)
    assert_equal "Tres", customer.last_name
  end

  def test_customer_can_query_creation_date
    customer = Customer.new(test_helper_customer_one_data)
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

  def test_customer_can_query_date_of_last_update
    customer = Customer.new(test_helper_customer_two_data)
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.updated_at
  end
end
