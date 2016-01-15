require 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_customer_can_query_id
    customer = test_helper_customer
    assert_equal 1, customer.id
  end

  def test_customer_can_query_first_name
    customer = test_helper_customer
    assert_equal "Joey", customer.first_name
  end

  def test_customer_can_query_last_name
    customer = test_helper_customer
    assert_equal "Ondricka", customer.last_name
  end

  def test_customer_can_query_creation_date
    customer = test_helper_customer
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

  def test_customer_can_query_date_of_last_update
    customer = test_helper_customer
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.updated_at
  end
end
