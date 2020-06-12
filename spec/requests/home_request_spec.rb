RSpec.describe 'Home', type: :request do
  describe 'GET root path' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status :success
    end
  end
end
