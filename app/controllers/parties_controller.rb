class PartiesController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    index:             proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties },
    show:              proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties(params[:party_id]) },
    lookup:            proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties.lookup(params[:source], params[:id]) },
    current:           proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties.current },
    letters:           proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties(params[:letter]) },
    a_to_z:            proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties.a_z_letters },
    lookup_by_letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parties.partial(params[:letters]) }
  }.freeze

  def index
    @parties, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/Party',
      ::Grom::Node::BLANK
    )

    @parties = @parties.sort_by(:name)
    @letters = @letters.map(&:value)
  end

  def show
    @party = @request.get.first
  end

  def lookup
    @party = @request.get.first

    redirect_to party_path(@party.graph_id)
  end

  def current
    @parties = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/Party'
    ).sort_by(:name)
  end

  def letters
    @parties, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/Party',
      ::Grom::Node::BLANK
    )

    @parties = @parties.sort_by(:name)
    @letters = @letters.map(&:value)
  end

  def a_to_z
    @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(ROUTE_MAP[:a_to_z].call)
  end

  def lookup_by_letters
    @parties, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/Party',
      ::Grom::Node::BLANK
    )

    return redirect_to party_path(@parties.first.graph_id) if @parties.size == 1

    @parties = @parties.sort_by(:name)
    @letters = @letters.map(&:value)
  end
end
