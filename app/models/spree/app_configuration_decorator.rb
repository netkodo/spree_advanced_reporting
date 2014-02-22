Spree::AppConfiguration.class_eval do
    preference :top_customers, :integer, :default => 5
    preference :top_products, :integer, :default => 5
end