require 'rails_helper'

RSpec.describe 'houses/members/current_letters', vcr: true do

  describe 'no dissolution' do
    before :each do
      allow(Parliament::Utils::Helpers::FlagHelper).to receive(:dissolution?).and_return(true)
      assign(:house, double(:house, name: 'House of Commons', graph_id: 'cqIATgUK'))
      assign(:people, [])
      assign(:current_person_type, 'MPs')
      assign(:other_person_type, 'Lords')
      assign(:other_house_id, 'm1EgVTLj')
      assign(:house_id, 'cqIATgUK')
      assign(:party_id, 'jF43Jxoc')
      assign(:letters, 'A')
      controller.params = { letter: 'a' }

      render
    end

    context 'header' do
      it 'will render the current person type' do
        expect(rendered).to match(/Current MPs/)
      end
    end

    context 'partials' do
      it 'will render letter navigation' do
        expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
      end

      # it 'will render person list' do
      #   expect(response).to render_template(partial: 'pugin/cards/_person-list')
      # end

      it 'will render pugin/elements/_list' do
        expect(response).to render_template('pugin/elements/_list')
      end

      context 'with bandiera dissolution flag set' do
        it 'will render dissolution message' do
          expect(response).to render_template(partial: 'shared/_dissolution_message')
        end
      end
    end
  end

  describe 'dissolution messaging' do
    before :each do
      allow(Parliament::Utils::Helpers::FlagHelper).to receive(:dissolution?).and_return(false)
      assign(:house, double(:house, name: 'House of Commons', graph_id: 'cqIATgUK'))
      assign(:people, [])
      assign(:current_person_type, 'MPs')
      assign(:other_person_type, 'Lords')
      assign(:other_house_id, 'm1EgVTLj')
      assign(:house_id, 'cqIATgUK')
      assign(:party_id, 'jF43Jxoc')
      assign(:letters, 'A')
      controller.params = { letter: 'a' }

      render
    end

    it 'will not render dissolution message' do
      expect(response).not_to render_template(partial: 'shared/_dissolution_message')
    end
  end

end
