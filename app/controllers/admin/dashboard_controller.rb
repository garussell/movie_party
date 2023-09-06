# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    before_action :require_admin

    def index; end
  end
end
