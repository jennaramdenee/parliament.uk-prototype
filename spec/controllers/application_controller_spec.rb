require 'rails_helper'

RSpec.describe ApplicationController, vcr: true do
  before(:each) do
    @controller = ApplicationController.new
  end

  context 'data formats' do
    it 'raises an error if data url is requested without providing data' do
      expect{@controller.data_url}.to raise_error(StandardError, 'Must provide valid data')
    end
  end
end
