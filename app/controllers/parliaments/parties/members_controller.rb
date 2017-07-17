module Parliaments
  module Parties
    class MembersController < ApplicationController
      before_action :data_check, :build_request

      ROUTE_MAP = {
        index:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliaments(params[:parliament_id]).parties(params[:party_id]).members },
        a_to_z:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliaments(params[:parliament_id]).parties(params[:party_id]).members },
        letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliaments(params[:parliament_id]).parties(params[:party_id]).members(params[:letter]) }
      }.freeze

      def index
        @parliament, @party, @people, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/ParliamentPeriod',
          'http://id.ukpds.org/schema/Party',
          'http://id.ukpds.org/schema/Person',
          ::Grom::Node::BLANK
        )

        @parliament = @parliament.first
        @party      = @party.first
        @people     = @people.sort_by(:sort_name)
        @letters    = @letters.map(&:value)
      end

      def a_to_z
        @parliament, @party, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/ParliamentPeriod',
          'http://id.ukpds.org/schema/Party',
          ::Grom::Node::BLANK
        )

        @parliament = @parliament.first
        @party      = @party.first
        @letters    = @letters.map(&:value)
      end

      def letters
        @parliament, @party, @people, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/ParliamentPeriod',
          'http://id.ukpds.org/schema/Party',
          'http://id.ukpds.org/schema/Person',
          ::Grom::Node::BLANK
        )

        @parliament = @parliament.first
        @party      = @party.first
        @people     = @people.sort_by(:sort_name)
        @letters    = @letters.map(&:value)
      end
    end
  end
end
