module People
  class HousesController < ApplicationController
    before_action :data_check

    def index
      person_id = params[:person_id]

      @person, @incumbencies = RequestHelper.filter_response_data(
      parliament_request.people(person_id).houses,
      'http://id.ukpds.org/schema/Person',
      'http://id.ukpds.org/schema/Incumbency'
      )

      @person = @person.first
      @incumbencies = @incumbencies.reverse_sort_by(:start_date)
    end

    def current
      person_id = params[:person_id]

      @person, @house = RequestHelper.filter_response_data(
      parliament_request.people(person_id).houses.current,
      'http://id.ukpds.org/schema/Person',
      'http://id.ukpds.org/schema/House'
      )

      @person = @person.first
      @house = @house.first
    end

    private

    ROUTE_MAP = {
      index: proc { |params| ParliamentHelper.parliament_request.people(params[:person_id]).houses },
      current: proc { |params| ParliamentHelper.parliament_request.people(params[:person_id]).houses.current }
    }.freeze

    def get_data_url
      ROUTE_MAP[params[:action].to_sym]
    end

  end
end
