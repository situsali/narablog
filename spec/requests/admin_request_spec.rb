# frozen_string_literal: true

RSpec.describe 'Admins', type: :request do
  context 'when user is not log in' do
    it 'returns 404' do
      get '/admin'
      expect(response).to have_http_status :not_found
    end
  end

  context 'when user is log in' do
    it 'also return 400 when user is not admin' do
      get '/admin'
      expect(response).to have_http_status :not_found
    end
  end
end
