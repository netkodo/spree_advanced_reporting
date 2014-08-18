class Spree::AdvancedReport::GeoReport::GeoSales < Spree::AdvancedReport::GeoReport
  def name
    I18n.t("adv_report.geo_report.sales.name")
  end

  def column
    I18n.t("adv_report.geo_report.sales.column")
  end

  def description
    I18n.t("adv_report.geo_report.sales.description")
  end

  def initialize(params)
    super(params)

    data = { :state => {}, :country => {} }
    orders.each do |order|
      sale = order.item_total - order.adjustment_total
      next unless order.bill_address
      if order.bill_address.state
        data[:state][order.bill_address.state_id] ||= {
            name: order.bill_address.state.name,
            sale: 0
        }
        data[:state][order.bill_address.state_id][:sale] += sale
      end
      if order.bill_address.country
        data[:country][order.bill_address.country_id] ||= {
            name: order.bill_address.country.name,
            sale: 0
        }
        data[:country][order.bill_address.country_id][:sale] += sale
      end
    end

    [:state, :country].each do |type|
      ruportdata[type] = Table(I18n.t("adv_report.geo_report.sales.table"))
      data[type].each { |k, v| ruportdata[type] << { "location" => v[:name], I18n.t("adv_report.sales") => v[:sale] } }
      ruportdata[type].sort_rows_by!([I18n.t("adv_report.sales")], :order => :descending)
      ruportdata[type].rename_column("location", type.to_s.capitalize)
      ruportdata[type].replace_column(I18n.t("adv_report.sales")) { |r| "$%0.2f" % r.send(I18n.t("adv_report.sales")) }
    end
  end
end
