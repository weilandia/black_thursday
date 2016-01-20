module InvoiceAnalysis
  def total_invoice_count
    engine.invoices.all.count
  end

  def average_invoices_per_merchant
    (total_invoice_count.to_f / total_merchant_count).round(2)
  end

  def invoice_count_per_merchant
   engine.merchants.all.map { |m| m.invoices.count }
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
    invoice_count_per_day.select { |day, i| i > avg + sd }.keys
  end

  def average_invoices_per_day
    mean(invoice_count_per_day.values).round(2)
  end

  def invoice_count_hash_by_day
    engine.invoices.all.map do |invoice|
      invoice.created_at.strftime("%A")
    end.group_by { |day| day }
  end

  def invoice_count_per_day
    invoice_count_hash_by_day.map { |k, v| [k, v.count] }.to_h
  end

  def total_invoice_count
    engine.invoices.all.count
  end

  def invoice_status(status)
    return 0.0 if invoice_count_by_status(status) == 0
    avg = invoice_count_by_status(status) / total_invoice_count.to_f
    (avg * 100).round(2)
  end


  def invoice_count_by_status(status)
    engine.invoices.all.select { |i| if i.status == status then i end }.length
  end
end
