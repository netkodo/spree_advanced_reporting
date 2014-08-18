require 'rails_helper'

describe Spree::Admin::ReportsController, :type => :controller do
  stub_authorization!
  # ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)

  let!(:taxonomy) { create(:taxonomy) }
  let!(:order)    { create(:completed_order_with_totals) }

  before do
    allow(controller).to receive(:base_report_render) { double("stub") }
    allow(controller).to receive(:base_report_top_render) { double("stub") }
    allow(controller).to receive(:geo_report_render) { double("stub") }
    allow(controller).to receive(:render) { double("stub") }
  end

  describe "GET outstanding" do
    before { spree_get :outstanding }

    it "assigns @orders" do
      expect(assigns(:orders)).to eq([order])
    end

    it "assigns @outstanding_balance" do
      expect(assigns(:outstanding_balance))
    end
  end

  describe "GET revenue" do
    before { spree_get :revenue }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_render" do
      expect(controller).to have_received(:base_report_render).with("revenue")
    end
  end

  describe "GET units" do
    before { spree_get :units }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_render" do
      expect(controller).to have_received(:base_report_render).with("units")
    end
  end

  describe "GET profit" do
    before { spree_get :profit }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_render" do
      expect(controller).to have_received(:base_report_render).with("profit")
    end
  end

  describe "GET count" do
    before { spree_get :count }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_render" do
      expect(controller).to have_received(:base_report_render).with("count")
    end
  end

  describe "GET top_products" do
    before { spree_get :top_products }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_top_render" do
      expect(controller).to have_received(:base_report_top_render).with("top_products")
    end
  end

  describe "GET top_customers" do
    before { spree_get :top_customers }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_top_render" do
      expect(controller).to have_received(:base_report_top_render).with("top_customers")
    end
  end

  describe "GET geo_revenue" do
    before { spree_get :geo_revenue }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #geo_report_render" do
      expect(controller).to have_received(:geo_report_render).with("geo_revenue")
    end
  end

  describe "GET geo_units" do
    before { spree_get :geo_units }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #geo_report_render" do
      expect(controller).to have_received(:geo_report_render).with("geo_units")
    end
  end

  describe "GET geo_profit" do
    before { spree_get :geo_profit }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #geo_report_render" do
      expect(controller).to have_received(:geo_report_render).with("geo_profit")
    end
  end

  describe "GET geo_sales" do
    before { spree_get :geo_sales }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #geo_report_render" do
      expect(controller).to have_received(:geo_report_render).with("geo_sales")
    end
  end

  describe "GET transactions" do
    before { spree_get :transactions }

    it "assigns @report" do
      expect(assigns(:report))
    end

    it "calls #base_report_top_render" do
      expect(controller).to have_received(:base_report_top_render).with("transactions")
    end
  end

end