class MetaController < ApplicationController
  before_action :disable_top_navigation, :data_check

  def index
    @meta_routes = []
    Rails.application.routes.routes.each do |route|
      path = route.path.spec.to_s

      next unless path.starts_with?('/meta/')

      path = path.sub(/\(.:format\)/, '')
      translation = path.split('/').last
      @meta_routes << { url: path, translation: translation }
    end

    render 'index'
  end

  def cookie_policy
    render 'cookie_policy'
  end

  private

  ROUTE_MAP = {
  }.freeze

<<<<<<< HEAD
  def get_data_url
    ROUTE_MAP[params[:action].to_sym]
  end

=======
  def data_url
    ROUTE_MAP[params[:action].to_sym]
  end
>>>>>>> b270c6c7c67c89b2600e383e8c15e36c32256962
end
