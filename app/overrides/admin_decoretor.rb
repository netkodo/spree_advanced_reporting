Deface::Override.new(
  :virtual_path => "spree/admin/shared/_configuration_menu",
  :name => "reports_admin_settings_line",
  :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
  :text => "<%= configurations_sidebar_menu_item t(:reports_configuration), edit_admin_report_settings_url %>",
  :disabled => false)
