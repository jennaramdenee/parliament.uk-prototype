class HomeController < ApplicationController
  before_action :disable_top_navigation, :disable_status_banner, :data_check

  def index; end

  def mps;
    enable_top_navigation; enable_status_banner

    @parliaments, @parties, @speaker = RequestHelper.filter_response_data(
      parliament_request.people.mps,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person'
    )

    @parties = @parties.multi_direction_sort({ member_count: :desc, name: :asc })
  end

  private

  ROUTE_MAP = {
    mps: proc { ParliamentHelper.parliament_request.people.mps }
  }.freeze

<<<<<<< HEAD
  def get_data_url
=======
  def data_url
>>>>>>> b270c6c7c67c89b2600e383e8c15e36c32256962
    ROUTE_MAP[params[:action].to_sym]
  end
end
