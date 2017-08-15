module Places
  class RegionsController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:             proc { ParliamentHelper.parliament_request.region_index },
    }.freeze

    # Renders a list of regions
    # @return [Array] Grom::Nodes of type 'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion'.
    def index
      @regions = RequestHelper.filter_response_data(
        @request,
        'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion',
        ::Grom::Node::BLANK
      )

      @regions = @regions.first

    end

  end
end
