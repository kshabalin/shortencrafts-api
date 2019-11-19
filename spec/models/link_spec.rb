require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'Validations' do
    subject(:link) do
      described_class.new(url: 'https://www.testlink.com/', url_hash: '06517b')
    end

    it 'is valid with valid attributes' do
      expect(link).to be_valid
    end

    it 'is not valid without a url' do
      link.url = nil
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'random string'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https://www.testlink.c'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https://www.testlink.'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https://www.testlink'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https://www.testlink'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https://testlink'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https:///testlink.com'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https:/testlink.com'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'htt:/testlink.com'
      expect(link).to_not be_valid
    end

    it 'is not valid with an incorrect url' do
      link.url = 'https/testlink.com'
      expect(link).to_not be_valid
    end

    it 'is not valid with an url hash less than 6 characters' do
      link.url_hash = '06517'
      expect(link).to_not be_valid
    end

    it 'is not valid without a url hash' do
      link.url_hash = nil
      expect(link).to_not be_valid
    end
  end

  describe 'Uniqueness' do
    subject(:link) do
      described_class.new(url: 'https://www.testlink.com/', url_hash: '06517b')
    end
    before do
      Link.create(url: 'https://www.testlink.com/', url_hash: '06517b')
    end

    it 'is invalid with a duplicate url hash' do
      link.valid?
      expect(link.errors[:url_hash]).to include('has already been taken')
    end

    it 'is valid with a duplicate url' do
      link.url_hash = 'b71560'
      expect(link).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:clicks) }
  end
end
