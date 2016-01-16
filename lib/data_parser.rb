require 'csv'
require 'json'
require 'bigdecimal'
require_relative 'item'
require_relative 'merchant'
require_relative 'customer'
require_relative 'transaction'
require_relative 'invoice_item'
require_relative 'invoice'

module DataParser

  def load_data(data, file_type)
    if file_type == :csv then load_csv_data(data)
    else load_json_data(data) end
  end

  def load_csv_data(data)
    from_csv(data[:items], items)
    from_csv(data[:merchants], merchants)
    from_csv(data[:invoices], invoices)
    from_csv(data[:invoice_items], invoice_items)
    from_csv(data[:transactions], transactions)
    from_csv(data[:customers], customers)
  end

  def load_json_data(data)
    from_json(data[:items], items)
    from_json(data[:merchants], merchants)
    from_json(data[:invoices], invoices)
    from_json(data[:invoice_items], invoice_items)
    from_json(data[:transactions], transactions)
    from_json(data[:customers], customers)
  end

  def json_convert(file)
    CSV.open(file, :headers => true).map { |x| x.to_h }.to_json
  end

  def from_json(data, repository)
    JSON.parse(json_convert(data), {:symbolize_names => true}).each do |hash|
    repository.create_instance(hash)
    end
  end

  def from_csv(data, repository)
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      data = {:id => row[:id].to_i,
              :name => row[:name],
              :description => row[:description],
              :unit_price => row[:unit_price],
              :merchant_id => row[:merchant_id],
              :invoice_id => row[:invoice_id],
              :item_id => row[:item_id],
              :credit_card_number => row[:credit_card_number],
              :credit_card_expiration_date => row[:credit_card_expiration_date],
              :customer_id => row[:customer_id],
              :status => row[:status],
              :result => row[:result],
              :quantity => row[:quantity],
              :first_name => row[:first_name],
              :last_name => row[:last_name],
              :created_at => Time.parse(row[:created_at]),
              :updated_at => Time.parse(row[:updated_at])}
      repository.create_instance(data)
    end
  end
end
