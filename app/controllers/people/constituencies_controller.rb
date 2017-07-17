module People
  class ConstituenciesController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.people(params[:person_id]).constituencies },
      current: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.people(params[:person_id]).constituencies.current }
    }.freeze

    def index
      @person, @seat_incumbencies = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
        @request,
        'http://id.ukpds.org/schema/Person',
        'http://id.ukpds.org/schema/SeatIncumbency'
      )

      @person = @person.first
      @seat_incumbencies = @seat_incumbencies.reverse_sort_by(:start_date)
    end

    def current
      @person, @constituency = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
        @request,
        'http://id.ukpds.org/schema/Person',
        'http://id.ukpds.org/schema/ConstituencyGroup'
      )

      @person = @person.first
      @constituency = @constituency.first
    end
  end
end
