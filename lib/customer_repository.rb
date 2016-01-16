require "csv"
require_relative '../lib/customer'

class CustomerRepository

  attr_reader :all_customers
  def from_csv(customer_data = "./data/customers.csv")
    @all_customers = []
    load_data(customer_data)
  end

  def load_data(data)
    customers = CSV.open data, headers: true, header_converters: :symbol
    customers.each do |row|
      customer_data= {:id =>  row[:id].to_i,
                      :first_name => row[:first_name],
                      :last_name => row[:last_name],
                      :created_at => Time.parse(row[:created_at]),
                      :updated_at => Time.parse(row[:updated_at])
                    }
      @all_customers << Customer.new(customer_data)
    end
  end

  def inspect
    "#<#{self.class} #{@all_customers.size} rows>"
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

  def find_all_by_first_name(first_name)
    @all_customers.select {|s| s.first_name.downcase.include? first_name.downcase}
  end

  def find_all_by_last_name(last_name)
    @all_customers.select {|s| s.last_name.downcase.include? last_name.downcase}
  end
end
