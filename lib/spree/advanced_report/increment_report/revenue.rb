# encoding: utf-8
class Spree::AdvancedReport::IncrementReport::Revenue < Spree::AdvancedReport::IncrementReport
  attr_accessor :shipping, :average_basket

  def name
    "Revenue, Shipping, Average basket"
  end

  def column
    "Revenue"
  end

  def description
    "Total order revenue without tax, shipping without tax and average basket(subtotal + shipping) amount without tax"
  end

  def initialize(params)
    super(params)
    self.total = 0
    self.shipping = 0
    self.average_basket = 0
    count_orders = 0

    self.orders.each do |order|
      if order.completed?
        count_orders += 1
        date = {}
        INCREMENTS.each do |type|
          date[type] = get_bucket(type, order.created_at)
          data[type][date[type]] ||= {
              :values => {
                  :value => 0,
                  :shipping => 0,
                  :average_basket => 0,
                  :orders_count => 0
              },
              :display => get_display(type, order.created_at),
          }
        end
        rev = order.item_total
        shipping = order.adjustments.where(originator_type: "Spree::ShippingMethod").sum(:amount)

        INCREMENTS.each do |type|
          data[type][date[type]][:values][:value] += rev
          data[type][date[type]][:values][:shipping] += shipping
          data[type][date[type]][:values][:orders_count] += 1
          data[type][date[type]][:values][:average_basket] = (data[type][date[type]][:values][:value] + data[type][date[type]][:values][:shipping]).to_f / data[type][date[type]][:values][:orders_count]
        end
        self.total += rev
        self.shipping += shipping
        self.average_basket = (self.total + self.shipping) / count_orders.to_f
      end

      generate_ruport_data(['shipping', 'average_basket'])

      # INCREMENTS.each do |type|
      #   ruportdata[type].replace_column("Revenue") do |r|
      #     Rails.logger.info r.inspect
      #     "%0.2f" % r["Revenue"]
      #     "%0.2f" % r["shipping"]
      #     "%0.2f" % r["average_basket"]
      #   end
      # end
    end
  end

  def format_total
    "#{self.date_text}<br>Total revenue: #{self.total.round(2)} Kč<br>Total shipping: #{self.shipping.round(2)} Kč<br>Average basket: #{self.average_basket.round(2)} Kč"
  end
end
