require 'mathn'
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
   array.inject(0){|accum, i| accum + i }
  end

  def mean(array)
   total = total(array)
   total/array.length.to_f
  end

  def sample_variance(mean, array)
   m = mean
   sum = array.inject(0){|accum, i| accum + (i-m)**2 }
   sum/(array.length-1).to_f
  end

  def standard_deviation(array)
    mean = mean(array)
    variance = sample_variance(mean, array)
    Math.sqrt(variance).round(2)
  end
end
