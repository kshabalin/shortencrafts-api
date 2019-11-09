require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    let(:user_params) do
      { username: 'Username',
        email: 'mail@mail.com',
        password: '12345678',
        password_confirmation: '12345678' }
    end

    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect do
          post :create, params: {user: user_params}
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user with nil username in the database' do
        user_params[:username] = nil
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with blank username in the database' do
        user_params[:username] = ''
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with nil email in the database' do
        user_params[:email] = nil
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with blank email in the database' do
        user_params[:email] = ''
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with incorrect email in the database' do
        user_params[:email] = 'emai@mail.c'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with incorrect email in the database' do
        user_params[:email] = 'emai@mail.'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with incorrect email in the database' do
        user_params[:email] = 'emai@mail'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with incorrect email in the database' do
        user_params[:email] = 'emaimail.com'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with incorrect email in the database' do
        user_params[:email] = '@mail.com'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with incorrect email in the database' do
        user_params[:email] = 'email()@mail.com'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with not matching passwords in the database' do
        user_params[:password_confirmation] = '87654321'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end

      it 'does not save the new user with too short password in the database' do
        user_params[:password] = '1234567'
        expect do
          post :create, params: {user: user_params}
        end.not_to change(User, :count)
      end
    end
  end
end
