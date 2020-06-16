# frozen_string_literal: true

RSpec.describe 'Admins', type: :request do
  context 'when user is not log in' do
    it 'returns 404 (not found)' do
      get '/admin'
      expect(response).to have_http_status :not_found
    end
  end

  context 'when user is log in' do
    it 'Returns 404 (not found) if user is not admin' do
      sign_in FactoryBot.create :user, :confirmed
      get '/admin'
      expect(response).to have_http_status :not_found
    end

    it 'return 302 (redirect) if admin user not confirm his email' do
      admin_not_confirmed = FactoryBot.create :user, isadmin: true
      sign_in admin_not_confirmed
      get '/admin'
      expect(response).to have_http_status :redirect
    end

    it 'returns 200 if user is admin' do
      sign_in FactoryBot.create :admin_user
      get '/admin'
      expect(response).to have_http_status :ok
    end
  end
end
