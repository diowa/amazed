require 'spec_helper'

describe 'Welcome' do
  context 'Index' do
    it "has title and a maze with 100 cells" do
      visit root_path

      expect(page).to have_title I18n.t('hello')
      expect(page).to have_css 'td', count: 100
    end
  end
end
