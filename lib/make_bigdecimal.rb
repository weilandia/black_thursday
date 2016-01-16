require 'bigdecimal'
module MakeBigDecimal
  def make_bigdecimal(unit_price)
    BigDecimal.new("#{unit_price[0..-3]}.#{unit_price[-2..-1]}")
  end
end
