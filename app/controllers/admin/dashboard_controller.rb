class Admin::DashboardController < BaseController
  before_action :require_admin

  def index
  end
end