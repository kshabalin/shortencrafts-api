require 'rails_helper'

RSpec.describe ClicksExtractor, type: :service do
  describe 'Extracting' do
    let(:user) do
      User.create(username: 'Username',
                  email: 'emai@mail.com',
                  password: '123456789',
                  password_confirmation: '123456789')
    end

    before do
      link = user.links.create(url: 'https://www.testlink.com/', url_hash: '06517b')
      5.times do
        link.clicks.create(country: 'Russian Federation', country_code: 'RU', occurred_at: '2019-11-01')
        link.clicks.create(country: 'United States', country_code: 'US', occurred_at: '2019-10-02')
        link.clicks.create(country: 'Canada', country_code: 'CA', occurred_at: '2019-09-03')
        link.clicks.create(country: 'New Zealand', country_code: 'NZ', occurred_at: '2019-08-04')
        link.clicks.create(country: 'Poland', country_code: 'PL', occurred_at: '2019-07-05')
      end
    end

    context 'without params' do
      it 'should return 5 clicks' do
        clicks = ClicksExtractor.call({}, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(25)
      end
    end

    context 'with params[:size]' do
      it 'should return 7 clicks' do
        clicks = ClicksExtractor.call({ size: 7 }, user)
        expect(clicks[:clicks]).to have(7).items
        expect(clicks[:total]).to eq(25)
      end
    end

    context 'with params[:page]' do
      it 'should return 5 clicks on page 0' do
        clicks = ClicksExtractor.call({ page: 0 }, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(25)
      end
      it 'should return 5 clicks on page 1' do
        clicks = ClicksExtractor.call({ page: 1 }, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(25)
      end
      it 'should return 5 clicks on page 4' do
        clicks = ClicksExtractor.call({ page: 4 }, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(25)
      end
      it 'should return 0 clicks on page 5' do
        clicks = ClicksExtractor.call({ page: 5 }, user)
        expect(clicks[:clicks]).to have(0).items
        expect(clicks[:total]).to eq(25)
      end
    end

    context 'with params[:page][:size]' do
      it 'should return 7 clicks on page 0 size 7' do
        clicks = ClicksExtractor.call({ page: 0, size: 7 }, user)
        expect(clicks[:clicks]).to have(7).items
        expect(clicks[:total]).to eq(25)
      end
      it 'should return 7 clicks on page 1 size 7' do
        clicks = ClicksExtractor.call({ page: 1, size: 7 }, user)
        expect(clicks[:clicks]).to have(7).items
        expect(clicks[:total]).to eq(25)
      end
      it 'should return 4 clicks on page 3 size 7' do
        clicks = ClicksExtractor.call({ page: 3, size: 7 }, user)
        expect(clicks[:clicks]).to have(4).items
        expect(clicks[:total]).to eq(25)
      end
    end

    context 'with params[:country]' do
      it 'should return 5 clicks' do
        clicks = ClicksExtractor.call({ country: 'Rus' }, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(5)
      end
    end

    context 'with params[:from]' do
      it 'should return 5 clicks' do
        clicks = ClicksExtractor.call({ from: '2019-09-03' }, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(15)
      end
    end

    context 'with params[:to]' do
      it 'should return 5 clicks' do
        clicks = ClicksExtractor.call({ to: '2019-09-03' }, user)
        expect(clicks[:clicks]).to have(5).items
        expect(clicks[:total]).to eq(10)
      end
    end
  end
end
