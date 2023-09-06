# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    def require_admin
      render file: '/public/404.html' unless current_admin?
    end
  end
end
