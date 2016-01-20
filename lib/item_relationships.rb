module ItemRelationships
  def item_relationships
    item_merchant_relationship
  end

  def item_merchant_relationship
    items.all.each do |item|
      item.merchant = merchants.find_by_id(item.merchant_id)
    end
  end
end
