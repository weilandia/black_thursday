module ItemAnalysis
  def total_item_count
    engine.items.all.count
  end

  def all_prices_array
    all_prices = []
    engine.merchants.all.each do |merchant|
      merchant.items.each { |item| all_prices << item }
    end
    all_prices
  end

  def golden_items
    all_prices = all_prices_array.map { |item| item.unit_price.to_f }
    sd = standard_deviation(all_prices)
    gold_items = all_prices_array.map do |item|
      if item.unit_price.to_f >= sd * 2 then item end
    end.compact
    gold_items
  end
end
