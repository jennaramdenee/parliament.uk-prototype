module People
  class ContactPointsController < ApplicationController
    before_action :data_check

    def index
      person_id = params[:person_id]

      @person, @contact_points = RequestHelper.filter_response_data(
      parliament_request.people(person_id).contact_points,
      'http://id.ukpds.org/schema/Person',
      'http://id.ukpds.org/schema/ContactPoint'
      )

      @person = @person.first
    end

    private

    ROUTE_MAP = {
      index: proc { |params| ParliamentHelper.parliament_request.people(params[:person_id]).contact_points }
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
end
