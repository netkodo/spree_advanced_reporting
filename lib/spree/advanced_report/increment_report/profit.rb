class Spree::AdvancedReport::IncrementReport::Profit < Spree::AdvancedReport::IncrementReport
  def name
    "Profit"
  end

  def column
    "Profit"
  end

  def description
    "Total profit in orders, where profit is the sum of item quantity times item price minus item cost price"
  end

  def initialize(params)
    super(params)
    self.total = 0
    self.orders.each do |order|
      date = {}
      INCREMENTS.each do |type|
        date[type] = get_bucket(type, order.created_at)
        data[type][date[type]] ||= {
          :values => {
            :value => 0
          },
          :display => get_display(type, order.created_at),
        }
      end
      profit = profit(order)
      INCREMENTS.each do |type|
        data[type][date[type]][:values][:value] += profit

      end
      self.total += profit
    end

    generate_ruport_data

    # INCREMENTS.each { |type| ruportdata[type].replace_column("Profit") { |r| "$%0.2f" % r["Profit"] } }
  end

  def format_total
    "Total: #{self.total.round(2)}"
  end
end
