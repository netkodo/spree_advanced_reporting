module Spree
  module Admin
    class ReportSettingsController < Spree::Admin::BaseController

      def update
        Spree::Config.set(params[:preferences])
        flash[:success] = t(:successfully_updated, :resource => t(:report_settings))
        redirect_to edit_admin_report_settings_path
      end
    end
  end

end
