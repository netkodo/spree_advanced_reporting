class Spree::Admin::AdvancedReportOverviewController < Spree::Admin::BaseController
  def index

    @reports  = Spree::Admin::ReportsController.available_reports
    @products = Spree::Product.all
    @taxons   = Spree::Taxon.all
    if defined?(MultiDomainExtension)
      @stores = Store.all
    end
    @report               = Spree::AdvancedReport::IncrementReport::Revenue.new({ :search => {} })
    @top_products_report  = Spree::AdvancedReport::TopReport::TopProducts.new({ :search => {} }, 5)
    @top_customers_report = Spree::AdvancedReport::TopReport::TopCustomers.new({ :search => {} }, 5)
    @top_customers_report.ruportdata.remove_column(I18n.t("adv_report.units"))

    # From overview_dashboard, Cleanup eventually
    orders       = Spree::Order.includes(:line_items).where("completed_at IS NOT null").order("completed_at DESC").limit(10)
    @last_orders = orders.inject([]) { |arr, o| arr << [o.bill_address.firstname, o.line_items.sum(:quantity), o.total, o.number]; arr }

    @best_taxons = Spree::Taxon.connection.select_rows("SELECT t.name, COUNT(li.quantity) FROM spree_line_items li INNER JOIN spree_variants v ON
           li.variant_id = v.id INNER JOIN spree_products p ON v.product_id = p.id INNER JOIN spree_products_taxons pt ON p.id = pt.product_id
           INNER JOIN spree_taxons t ON pt.taxon_id = t.id WHERE t.taxonomy_id = #{Spree::Taxonomy.last.id} GROUP BY t.name ORDER BY COUNT(li.quantity) DESC LIMIT 5;")
  end
end
