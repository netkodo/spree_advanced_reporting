class Spree::AdvancedReport::IncrementReport < Spree::AdvancedReport
  INCREMENTS = [:daily, :weekly, :monthly, :quarterly, :yearly]
  attr_accessor :increments, :dates, :total, :all_data

  def initialize(params)
    super(params)
  
    self.increments = INCREMENTS
    # self.ruportdata = INCREMENTS.inject({}) { |h, inc| h[inc] = Table(%w[key display value]); h }
    self.ruportdata = INCREMENTS.inject({}) { |h, inc| h[inc] = Table(%w[key display]); h }
    self.data = INCREMENTS.inject({}) { |h, inc| h[inc] = {}; h }

    self.dates = {
      :daily => {
        :date_bucket => "%F",
        :date_display => "%m-%d-%Y",
        :header_display => 'Daily',
      },
      :weekly => {
        :header_display => 'Weekly'
      },
      :monthly => {
        :date_bucket => "%Y-%m",
        :date_display => "%B %Y",
        :header_display => 'Monthly',
      },
      :quarterly => {
        :header_display => 'Quarterly'
      },
      :yearly => {
        :date_bucket => "%Y",
        :date_display => "%Y",
        :header_display => 'Yearly',
      }
    }
  end

  def generate_ruport_data(additional_columns = [])
    columns = additional_columns.blank? ? %w[key display value] : %w[key display value] + additional_columns
    self.ruportdata = INCREMENTS.inject({}) { |h, inc| h[inc] = Table(columns); h } if additional_columns.present?
    self.all_data = Table(columns)

    INCREMENTS.each do |inc|
      data[inc].each do |k,v|
        values = {}
        v[:values].each do |_, value|
          values[_.to_s] = value
        end
        ruportdata[inc] << { "key" => k, "display" => v[:display] }.merge(values)
      end
      ruportdata[inc].data.each do |p|
        values = { "increment" => inc.to_s.capitalize, "key" => p.data["key"], "display" => p.data["display"]}
        additional_columns.each {|col| values.merge({col => p.data[col]})}
        # self.all_data << { "increment" => inc.to_s.capitalize, "key" => p.data["key"], "display" => p.data["display"], "value" => p.data["value"], "cancelled" => p.data["cancelled"], "ratio" => p.data["ratio"] }
        self.all_data << { "increment" => inc.to_s.capitalize, "key" => p.data["key"], "display" => p.data["display"], "value" => p.data["value"]}.merge(values)
      end
      ruportdata[inc].sort_rows_by!(["key"])
      ruportdata[inc].remove_column("key")
      ruportdata[inc].rename_column("display", dates[inc][:header_display])
      ruportdata[inc].rename_column("value", self.class.name.split('::').last)
    end
    self.all_data.sort_rows_by!(["key"])
    self.all_data.remove_column("key")

    # self.all_data = Grouping(self.all_data, :by => "increment")
    self.all_data

  end
  
  def get_bucket(type, completed_at)
    if type == :weekly
      return completed_at.beginning_of_week.strftime("%Y-%m-%d")
    elsif type == :quarterly
      return completed_at.beginning_of_quarter.strftime("%Y-%m")
    end
    completed_at.strftime(dates[type][:date_bucket])
  end

  def get_display(type, completed_at)
    if type == :weekly
      #funny business
      #next_week = completed_at + 7
      return completed_at.beginning_of_week.strftime("%m-%d-%Y") # + ' - ' + next_week.beginning_of_week.strftime("%m-%d-%Y")
    elsif type == :quarterly
      return completed_at.strftime("%Y") + ' Q' + (completed_at.beginning_of_quarter.strftime("%m").to_i/3 + 1).to_s
    end
    completed_at.strftime(dates[type][:date_display])
  end

  def format_total
    self.total 
  end
end
