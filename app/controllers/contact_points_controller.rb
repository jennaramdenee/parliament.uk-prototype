class ContactPointsController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    index: proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.contact_points },
    show:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.contact_points(params[:contact_point_id]) }
  }.freeze

  def index
    @contact_points = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/ContactPoint'
    )
  end

  def show
    @contact_point = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/ContactPoint'
    ).first

    vcard = create_vcard(@contact_point)
    send_data vcard.to_s, filename: 'contact.vcf', disposition: 'attachment', data: { turbolink: false }
  end
end
