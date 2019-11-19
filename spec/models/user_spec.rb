require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject(:user) do
      described_class.new(username: 'Username',
                          email: 'emai@mail.com',
                          password: '123456789',
                          password_confirmation: '123456789')
    end

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user.username = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid with incorrect email format' do
      user.email = 'emai@mail.c'
      expect(user).to_not be_valid
    end

    it 'is not valid with incorrect email format' do
      user.email = 'emai@mail.'
      expect(user).to_not be_valid
    end

    it 'is not valid with incorrect email format' do
      user.email = 'emai@mail'
      expect(user).to_not be_valid
    end

    it 'is not valid with incorrect email format' do
      user.email = 'emaimail.com'
      expect(user).to_not be_valid
    end

    it 'is not valid with incorrect email format' do
      user.email = '@mail.com'
      expect(user).to_not be_valid
    end

    it 'is not valid with incorrect email format' do
      user.email = 'email()@mail.com'
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a password_confirmation' do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end

    it 'is not valid when a password does not match' do
      user.password_confirmation = '98765431'
      expect(user).to_not be_valid
    end

    it 'is not valid when a password is less than 8 characters' do
      user.password = '1234567'
      expect(user).to_not be_valid
    end
  end

  describe 'Uniqueness' do
    subject(:user) do
      described_class.new(username: 'Username',
                          email: 'emai@mail.com',
                          password: '123456789',
                          password_confirmation: '123456789')
    end
    before do
      User.create(username: 'Username',
                  email: 'emai@mail.com',
                  password: '123456789',
                  password_confirmation: '123456789')
    end

    it 'is invalid with a duplicate username' do
      user.valid?
      expect(user.errors[:username]).to include('has already been taken')
    end

    it 'is invalid with a duplicate email address' do
      user.username = 'Another Username'
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'is valid with a unique email address and username' do
      user.email = 'anothermail@mail.com'
      user.username = 'Another Username'
      expect(user).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:links) }
  end
end
