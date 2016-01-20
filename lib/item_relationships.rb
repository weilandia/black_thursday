module ItemRelationships
  def item_relationships
    item_merchant_relationship
  end

  def item_merchant_relationship
    items.all.each { |i| i.merchant = merchants.find_by_id(i.merchant_id) }
  end
end
