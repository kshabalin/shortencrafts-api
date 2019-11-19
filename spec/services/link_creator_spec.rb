require 'rails_helper'

RSpec.describe LinkCreator, type: :service do
  describe 'Creating' do
    let(:user) do
      User.create(username: 'Username',
                  email: 'emai@mail.com',
                  password: '123456789',
                  password_confirmation: '123456789')
    end

    let(:link_params) do
      { url: 'https://www.testlink1.com/', url_hash: '06517c' }
    end

    context 'without a user' do
      it 'creates the new link in the database' do
        link = LinkCreator.call(link_params, nil)
        expect(link.present?).to eq(true)
      end

      it 'finds the existing link in the database' do
        link = LinkCreator.call(link_params, nil)
        expect(link.present?).to eq(true)
        expect(link.id).to eq(1)
      end
    end

    context 'with a user' do
      it 'creates the new link in the database' do
        link = LinkCreator.call(link_params, user)
        expect(link.present?).to eq(true)
        expect(link.user_id).to eq(1)
      end

      it 'finds the existing link in the database' do
        link = LinkCreator.call(link_params, user)
        expect(link.present?).to eq(true)
        expect(link.id).to eq(1)
        expect(link.user_id).to eq(1)
      end
    end
  end
end
