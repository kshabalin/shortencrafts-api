require 'rails_helper'

RSpec.describe LinksExtractor, type: :service do
  describe 'Extracting' do
    let(:user) do
      User.create(username: 'Username',
                  email: 'emai@mail.com',
                  password: '123456789',
                  password_confirmation: '123456789')
    end

    before do
      9.times do |i|
        user.links.create(url: "https://www.testlink#{i}.com/",
                          url_hash: "#{i}6517b")
      end
    end

    context 'without params' do
      it 'should return 5 links' do
        links = LinksExtractor.call({}, user)
        expect(links[:links]).to have(5).items
        expect(links[:total]).to eq(9)
      end
    end

    context 'with params[:size]' do
      it 'should return 7 links' do
        links = LinksExtractor.call({ size: 7 }, user)
        expect(links[:links]).to have(7).items
        expect(links[:total]).to eq(9)
      end
    end

    context 'with params[:page]' do
      it 'should return 5 links on page 0' do
        links = LinksExtractor.call({ page: 0 }, user)
        expect(links[:links]).to have(5).items
        expect(links[:total]).to eq(9)
      end
      it 'should return 4 links on page 1' do
        links = LinksExtractor.call({ page: 1 }, user)
        expect(links[:links]).to have(4).items
        expect(links[:total]).to eq(9)
      end
    end
  end
end
