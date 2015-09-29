class Spree::AdvancedReport::IncrementReport::Count < Spree::AdvancedReport::IncrementReport
  attr_accessor :cancelled, :ratio

  def name
    "Order Count"
  end

  def column
    "Count"
  end

  def description
    "Total number of orders, cancelled orders and cancelled orders ratio"
  end

  def initialize(params)
    super(params)
    self.total = 0
    self.cancelled = 0
    self.ratio = 0
    self.orders.where("state = 'complete' or state = 'canceled'").each do |order|
      date = {}
      INCREMENTS.each do |type|
        date[type] = get_bucket(type, order.created_at)
        data[type][date[type]] ||= {
          :values => {
              :value => 0,
              :cancelled => 0,
              :ratio => 0
          },
          :display => get_display(type, order.created_at),
        }
      end
      # order_count = order_count(order)
      INCREMENTS.each do |type|
        data[type][date[type]][:values][:value] += 1
        data[type][date[type]][:values][:cancelled] += 1 if order.state == 'canceled'
        data[type][date[type]][:values][:ratio] = "#{((data[type][date[type]][:values][:cancelled].to_f) / (data[type][date[type]][:values][:value].to_f) * 100).round(2)} %"
      end
      self.total += 1
      self.cancelled += 1 if order.state == 'canceled'
    end

    self.ratio = self.cancelled.to_f / self.total * 100

    generate_ruport_data(['cancelled', 'ratio'])

    # INCREMENTS.each { |type| ruportdata[type].replace_column("ratio") { |r| "0.2f" % r["ratio"] } }
  end

  def format_total
    "#{self.date_text}<br>Total orders: #{self.total}<br>Total cancelled orders: #{self.cancelled}<br>Cancelled ratio: #{self.ratio.round(2)} %<br>"
  end

end
