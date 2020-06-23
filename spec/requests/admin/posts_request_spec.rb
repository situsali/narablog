RSpec.describe 'Admin::Posts', type: :request do
  let(:article) { FactoryBot.create :post }

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

  context 'when admin user is logged in' do
    let(:admin_user) { FactoryBot.create :admin_user }

    before { sign_in admin_user }

    describe 'GET /index' do
      it 'returns http success' do
        get admin_posts_path
        expect(response).to have_http_status :success
      end
    end

    describe 'GET /show' do
      it 'returns http success' do
        get admin_post_path id: article
        expect(response).to have_http_status :success
      end
    end

    describe 'GET /edit' do
      it 'returns http success' do
        get edit_admin_post_path id: article
        expect(response).to have_http_status :success
      end
    end

    describe 'GET /new' do
      it 'returns http success' do
        get new_admin_post_path
        expect(response).to have_http_status :success
      end
    end

    describe 'POST /create' do
      it 'returns http success' do
        post admin_posts_path, params: { title: Faker::Lorem.sentence,
                                         body: Faker::Lorem.paragraph,
                                         user: admin_user }

        expect(response).to have_http_status(:success)
      end
    end

    describe 'PATCH /update' do
      it 'returns http success' do
        patch admin_post_path id: article,
                              params: { title: Faker::Lorem.sentence,
                                        body: Faker::Lorem.paragraph,
                                        user: admin_user }

        expect(response).to have_http_status :success
      end
    end

    describe 'PUT /update' do
      it 'returns http success' do
        put admin_post_path id: article,
                            params: { title: Faker::Lorem.sentence,
                                      body: Faker::Lorem.paragraph,
                                      user: admin_user }

        expect(response).to have_http_status :success
      end
    end

    describe 'DELETE /destroy' do
      it 'returns http success' do
        delete admin_post_path id: article
        expect(response).to have_http_status :success
      end
    end
  end
end
