require 'rails_helper'

RSpec.describe Click, type: :model do
  describe "Associations" do
    it { should belong_to(:link) }
  end

  describe "Validations" do
    let(:link) { Link.create(url: 'https://www.testlink.com/', url_hash: '06517b') }
    let(:click_params) { {country: 'Russian Federation', country_code: 'RU'} }

    it { should validate_presence_of(:link) }

    it 'is valid with valid attributes' do
      click = link.clicks.new(click_params)
      expect(click).to be_valid
    end

    it 'is not valid without a country' do
      click_params[:country] = nil
      click = link.clicks.new(click_params)
      expect(click).to_not be_valid
    end

    it 'is not valid without a country code' do
      click_params[:country_code] = nil
      click = link.clicks.new(click_params)
      expect(click).to_not be_valid
    end
  end
end
