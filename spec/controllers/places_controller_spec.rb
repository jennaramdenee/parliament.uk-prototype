require 'rails_helper'

RSpec.describe PlacesController, vcr: true do

  describe 'GET show' do
    before(:each) do
      get :show, params: { place_id: '7000000000041422' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @regions, @constituencies' do
      expect(assigns(:region)).to be_a(Grom::Node)
      expect(assigns(:region).type).to eq('http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion>')

      assigns(:constituencies).each do |constituency|
        expect(constituency).to be_a(Grom::Node)
        expect(constituency.type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
      end
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

  end

end
