require_relative 'customer'
require_relative 'data_parser'
require_relative 'repositories'

class CustomerRepository
  include DataParser
  include Repositories
  attr_reader :all_customers,
              :all

  def initialize(all=[])
    instantiate_repos(all)
  end

  def inspect
    "#<#{self.class} #{all_customers.size} rows>"
  end

  def create_instance(customer_data)
    customer = Customer.new(customer_data)
    @all << customer
  end

  def all_customers
    @all
  end

  def find_all_by_first_name(name)
    all_customers.select {|s| s.first_name.downcase.include? name.downcase}
  end

  def find_all_by_last_name(name)
    all_customers.select {|s| s.last_name.downcase.include? name.downcase}
  end
end
