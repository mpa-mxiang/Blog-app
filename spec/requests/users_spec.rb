require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'displays user information' do
      # Create some sample users manually
      user1 = User.create(name: 'User 1')
      user2 = User.create(name: 'User 2')

      get users_path
      expect(response.body).to include('All Users')
      expect(response.body).to include(user1.name)
      expect(response.body).to include(user2.name)
    end
  end

  describe 'GET /users/:id' do
    it 'returns a successful response' do
      user = User.create(name: 'Test User')
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      user = User.create(name: 'Test User')
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'displays user information' do
      user = User.create(name: 'Test User')

      get user_path(user)
      expect(response.body).to include('User Details')
      expect(response.body).to include(user.name)
    end
  end
end