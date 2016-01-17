require 'csv'
require 'json'
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

  def from_csv(data, repository)
    JSON.parse(json_convert(data), {:symbolize_names => true}).each do |hash|
    repository.create_instance(hash)
    end
  end

  def from_json(data, repository)
    JSON.parse(File.read(data), {:symbolize_names => true}).each do |hash|
    repository.create_instance(hash)
    end
  end

  def json_convert(file)
    CSV.open(file, :headers => true).map { |x| x.to_h }.to_json
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
end
