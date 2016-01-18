module DateValidation
  def time_object(date_string)
    if date_string.nil? then Time.parse"0000-01-01 00:00:00 UTC"
    else Time.parse(date_string) end
  end
end
