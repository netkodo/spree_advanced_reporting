require 'rails_helper'

describe Spree::Admin::AdvancedReportOverviewController, :type => :controller do
  stub_authorization!
  # ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)

  let!(:taxonomy) { create(:taxonomy) }
  let!(:order)    { create(:completed_order_with_totals) }
  let(:taxons)    { Spree::Taxon.all }
  let(:products)  { Spree::Product.all }

  describe "GET index" do
    before do
      spree_get :index
    end

    it "assigns @reports" do
      expect(assigns(:reports)).to be_kind_of(Hash)
      expect(assigns(:reports)).to_not be_empty
    end

    it "assigns @taxons" do
      expect(assigns(:taxons)).to eq taxons
    end

    it "assigns @products" do
      expect(assigns(:products)).to eq products
    end

    it "assigns @best_taxons" do
      expect(assigns(:best_taxons)).to be_kind_of(Array)
    end

    it "assigns @last_orders" do
      expect(assigns(:last_orders)).to_not be_empty
    end

    it "assigns @top_customers_report" do
      expect(assigns(:top_customers_report)).to be_kind_of(Spree::AdvancedReport::TopReport::TopCustomers)
    end
  end
end