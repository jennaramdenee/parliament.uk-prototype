class PlacesController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    show:              proc { |params| ParliamentHelper.parliament_request.region_constituencies.set_url_params({ region: params[:place_id] }) },
  }.freeze


  def index
  end

  # Renders a single place given a place id.
  # @controller_action_param :region_id [String] 8 character identifier that identifies constituency in graph database.
  # @return [Grom::Node] object with type 'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion'.

  def show
    @regions, @constituencies = RequestHelper.filter_response_data(
    @request,
      'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion',
      'http://id.ukpds.org/schema/ConstituencyGroup',
      ::Grom::Node::BLANK
    )

    @region = @regions.first
  end
end
