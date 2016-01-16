require "csv"
require_relative '../lib/customer'
require_relative 'data_parser'

class CustomerRepository
  include DataParser
  attr_reader :all_customers
  def initialize
    @all_customers = []
  end

  def inspect
    "#<#{self.class} #{@all_customers.size} rows>"
  end

  def create_instance(customer_data)
    customer = Customer.new(customer_data)
    @all_customers << customer
  end

  def all
    all_customers
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_by_id(customer_id)
    search_result = @all_customers.select {|search| search.id == customer_id}[0]
    exact_search(search_result)
  end

  def find_all_by_first_name(f_name)
    @all_customers.select {|s| s.first_name.downcase.include? f_name.downcase}
  end

  def find_all_by_last_name(l_name)
    @all_customers.select {|s| s.last_name.downcase.include? l_name.downcase}
  end
end
