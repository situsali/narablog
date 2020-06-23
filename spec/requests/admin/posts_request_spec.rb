RSpec.describe 'Admin::Posts', type: :request do
  context 'when user is not login' do
    it 'returns http not found' do
      get admin_posts_path
      expect(response).to have_http_status :not_found
    end
  end

  context 'when logged in user is not admin' do
    it 'returns http not found' do
      sign_in FactoryBot.create :user, :confirmed
      get admin_posts_path
      expect(response).to have_http_status :not_found
    end
  end

  context 'when admin user is admin' do
    let(:admin_user) { FactoryBot.create :admin_user }

    before { sign_in admin_user }

    describe 'GET /index' do
      it 'returns http success' do
        get '/admin/posts/index'
        expect(response).to have_http_status(:success)
      end
    end

    xdescribe "GET /show" do
      it "returns http success" do
        get admin_post_path id: 1
        expect(response).to have_http_status(:success)
      end
    end

    xdescribe "GET /edit" do
      it "returns http success" do
        get "/admin/posts/edit"
        expect(response).to have_http_status(:success)
      end
    end

    xdescribe "GET /new" do
      it "returns http success" do
        get "/admin/posts/new"
        expect(response).to have_http_status(:success)
      end
    end

    xdescribe "GET /create" do
      it "returns http success" do
        get "/admin/posts/create"
        expect(response).to have_http_status(:success)
      end
    end

    xdescribe "GET /update" do
      it "returns http success" do
        get "/admin/posts/update"
        expect(response).to have_http_status(:success)
      end
    end

    xdescribe "GET /destroy" do
      it "returns http success" do
        get "/admin/posts/destroy"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
