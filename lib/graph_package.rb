require 'googlecharts'
module GraphPackage

  def g_merchant_rev(data = all_merchants.map(&:revenue))
    legend = all_merchants.map(&:name)
    Gchart.pie(theme: :thirty7signals,
               title: "All Merchants by Revenue",
               labels: legend,
               data: data,
               size: '750x375')
  end

end
