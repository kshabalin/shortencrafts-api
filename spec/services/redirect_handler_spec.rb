require 'rails_helper'

RSpec.describe RedirectHandler, type: :service do
  describe 'Default redirecting' do
    it 'returns default redirect url' do
      redirect_url = RedirectHandler.call('fake hash', '::1')
      expect(redirect_url).to eq('localhost:3000')
    end
  end

  describe 'Redirecting' do
    let(:link) do
      Link.create(url: 'https://www.testlink.com/', url_hash: '06517b')
    end

    it 'returns redirect url' do
      redirect_url = RedirectHandler.call(link.url_hash, '::1')
      expect(redirect_url).to eq(link.url)
    end
  end
end
