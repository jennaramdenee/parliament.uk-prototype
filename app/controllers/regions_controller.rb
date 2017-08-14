class RegionsController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    index:             proc { ParliamentHelper.parliament_request.region_index },
    show:              proc { |params| ParliamentHelper.parliament_request.region_constituencies.set_url_params({ region: params[:region_id] }) },
  }.freeze

  def index
    @regions = RequestHelper.filter_response_data(
      @request,
      'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion',
      ::Grom::Node::BLANK
    )
  end

  def show
    @regions, @constituency, @seat_incumbencies, @party = RequestHelper.filter_response_data(
      @request,
      'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion',
      'http://id.ukpds.org/schema/ConstituencyGroup',
      'http://id.ukpds.org/schema/SeatIncumbency',
      'http://id.ukpds.org/schema/Party',
      ::Grom::Node::BLANK
    )
    @constituency = @constituency.first
    @seat_incumbencies = @seat_incumbencies.reverse_sort_by(:start_date)

    @current_incumbency = @seat_incumbencies.shift if !@seat_incumbencies.empty? && @seat_incumbencies.first.current?

    @current_party_membership = @current_incumbency.member.party_memberships.select(&:current?)&.select(&:party)&.first

    @party = @current_incumbency ? @current_party_membership.party : @party.first
  end
end
