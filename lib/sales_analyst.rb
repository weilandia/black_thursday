require_relative 'sales_engine'
require_relative 'merchant_analysis'
require_relative 'item_analysis'
require_relative 'invoice_analysis'

class SalesAnalyst
  include MerchantAnalysis
  include ItemAnalysis
  include InvoiceAnalysis
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def total(array)
   array.inject(0) { |a, e| a + e }
  end

  def mean(array)
    total = total(array)
    total / array.length.to_f
  end

  def sample_variance(mean, array)
    m = mean
    sum = array.inject(0){|accum, i| accum + (i-m)**2 }
    sum / (array.length-1).to_f
  end

  def standard_deviation(array)
    mean = mean(array)
    variance = sample_variance(mean, array)
    Math.sqrt(variance).round(2)
  end

  def total_revenue_by_date(date)
    invoices = @engine.invoices.find_all_by_date(date)
    invoices = invoices.select { |i| i.is_paid_in_full? }
    return 0.0 if invoices.empty?
    invoices.map { |i| i.total }.inject(:+) / 100
  end
end
