require 'googlecharts'
module GraphPackage

  def g_merchant_rev(data = all_merchants.map(&:revenue))
    legend = all_merchants.map(&:name)
    graph = Gchart.pie(theme: :thirty7signals,
               title: "All Merchants by Revenue",
               labels: legend,
               data: data,
               size: '750x375')
    File.write('./graphs/all_merchants_by_revenue', graph)
  end

  def g_merchants_with_pending_invs
    merchants = merchants_with_pending_invoices
    paid_invs = merchants.map do |m|
      m.invoices.select { |i| i.is_paid_in_full? }
    end.map(&:count)

    pending_invs = merchants.map do |m|
      m.invoices.select { |i| i.is_pending? }
    end.map(&:count)

    graph = Gchart.bar( data: [paid_invs, pending_invs],
                        :title => 'Merchants with Pending Invoices',
                        :legend => merchants,
                        size: '750x375',
                        theme: :thirty7signals)

    File.write('./graphs/merchants_with_pending_invoices', graph)
  end

end
