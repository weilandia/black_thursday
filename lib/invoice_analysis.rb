module InvoiceAnalysis
  def total_invoice_count
    @engine.invoices.all.count
  end

  def average_invoices_per_merchant
    (total_invoice_count.to_f / total_merchant_count).round(2)
  end

  def invoice_count_per_merchant
   invoices_per_merchant = []
   @engine.merchants.all.each do |merchant|
     invoices_per_merchant << merchant.invoices.count
   end
   invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_count_per_merchant)
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(invoice_count_per_day.values)
  end

  def top_days_by_invoice_count
    sd = average_invoices_per_day_standard_deviation
    avg = average_invoices_per_day
     invoice_count_per_day.select do |day, count|
       count > avg + sd
    end.keys
  end

  def average_invoices_per_day
    mean(invoice_count_per_day.values).round(2)
  end

  def invoice_count_hash_by_day
    all_invoice_days = []
    @engine.invoices.all.each do |invoice|
      all_invoice_days << invoice.created_at.strftime("%A")
    end
    all_invoice_days.group_by { |day| day }
  end

  def invoice_count_per_day
    hash = invoice_count_hash_by_day
    hash.map do |k, v|
      [k, v.count]
    end.to_h
  end

  def total_invoice_count
    @engine.invoices.all.count
  end

  def invoice_status(status)
    return 0.0 if invoice_count_by_status(status) == 0
    ((invoice_count_by_status(status) / total_invoice_count.to_f) * 100).round(2)
  end


  def invoice_count_by_status(status)
    @engine.invoices.all.select do |invoice|
      if invoice.status == status
        invoice
      end
    end.length
  end
end
