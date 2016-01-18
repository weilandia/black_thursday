require 'bigdecimal'
module UnitPrice
  def unit_price_bigdecimal(unit_price)
    if unit_price.nil? then unit_price = 0 end
    BigDecimal.new(unit_price)
  end

  def unit_price_in_dollars
    (unit_price.to_f / 100).round(2)
  end
end
