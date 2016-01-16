require "csv"
require_relative '../lib/merchant'

class MerchantRepository

  attr_reader :all_merchants
  def from_csv(merchant_data = "./data/merchants.csv")
    @all_merchants = []
    load_data(merchant_data)
  end

  def load_data(data)
    merchants = CSV.open data, headers: true, header_converters: :symbol
    merchants.each do |row|
      merchant_data= {:id =>  row[:id].to_i,
                      :name => row[:name],
                      :created_at => Time.parse(row[:created_at]),
                      :updated_at => Time.parse(row[:updated_at])
                    }
      @all_merchants << Merchant.new(merchant_data)
    end
  end

  def inspect
    "#<#{self.class} #{@all_merchants.size} rows>"
  end

  def all
    all_merchants
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_by_id(merchant_id)
    search_result = @all_merchants.select {|search| search.id == merchant_id}[0]
    exact_search(search_result)
  end

  def find_by_name(mer_name)
    result = @all_merchants.select {|s| s.name.downcase == mer_name.downcase}[0]
    exact_search(result)
  end

  def find_all_by_name(search_frag)
    @all_merchants.select {|s| s.name.downcase.include? search_frag.downcase}
  end
end
