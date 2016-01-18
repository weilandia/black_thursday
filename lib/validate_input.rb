module ValidateInput
  def validate_integer(string_to_integer_input)
    return if string_to_integer_input.nil?
    string_to_integer_input.to_i
  end

  def validate_symbol(string_to_symbol_input)
    return if string_to_symbol_input.nil?
    string_to_symbol_input.to_sym
  end
end
