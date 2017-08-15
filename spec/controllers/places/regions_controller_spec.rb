require 'rails_helper'

RSpec.describe Places::RegionsController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @regions, @constituencies' do
      expect(assigns(:region)).to be_a(Grom::Node)
      expect(assigns(:region).type).to eq('http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion>')
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

  end

end
