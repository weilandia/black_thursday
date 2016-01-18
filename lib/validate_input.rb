require 'bigdecimal'
module ValidateInput
  def validate_integer(string_to_integer_input)
    return if string_to_integer_input.nil?
    string_to_integer_input.to_i
  end

  def validate_symbol(string_to_symbol_input)
    return if string_to_symbol_input.nil?
    string_to_symbol_input.to_sym
  end

  def time_object(date_string)
    if date_string.nil? then Time.parse"0000-01-01 00:00:00 UTC"
    else Time.parse(date_string) end
  end

  def unit_price_bigdecimal(unit_price)
    return if unit_price.nil?
    BigDecimal.new(unit_price)
  end

  def unit_price_in_dollars
    return if unit_price.nil?
    (unit_price.to_f / 100).round(2)
  end
end
