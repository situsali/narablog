RSpec.describe "Admin::Categories", type: :request do
  context 'when user is not login' do
    it 'returns http not found' do
      get admin_categories_path
      expect(response).to have_http_status :not_found
    end
  end

  context 'when logged in user is not admin' do
    it 'returns http not found' do
      sign_in FactoryBot.create :user, :confirmed
      get admin_categories_path
      expect(response).to have_http_status :not_found
    end
  end

  context 'when admin user is logged in' do
    let(:admin_user) { FactoryBot.create :admin_user }
    let(:category) { FactoryBot.create :category }

    before { sign_in admin_user }

    describe 'GET /index' do
      it 'returns http success' do
        get admin_categories_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /show' do
      it 'returns http success' do
        get admin_category_path(category)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /edit' do
      it 'returns http success' do
        get edit_admin_category_path id: category
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /new' do
      it 'returns http success' do
        get new_admin_category_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /create' do
      it 'returns http redirect and success to create a category' do
        category_name = Faker::Lorem.word
        post admin_categories_path, params: { category: { name: category_name,
                                                        slug: '',
                                                        description: '' } }

        expect(response).to have_http_status :redirect
        expect(Category.last.name).to eq category_name
      end
    end

    describe 'PATCH /update' do
      it 'returns http redirect and success to update a category' do
        category_name = Faker::Lorem.word
        patch admin_category_path id: category,
                                  params: { category: { name: category_name,
                                                        slug: 'edited',
                                                        description: '' } }

        category.reload
        expect(response).to have_http_status :redirect
        expect(category.name).to eq category_name
      end
    end

    describe 'PUT /update' do
      it 'returns http redirect and success to update a category' do
        category_name = Faker::Lorem.word
        put admin_category_path id: category,
                                params: { category: { name: category_name,
                                                      slug: 'edited',
                                                      description: '' } }

        category.reload
        expect(response).to have_http_status :redirect
        expect(category.name).to eq category_name
      end
    end

    describe 'DELETE /destroy' do
      it 'returns http redirect' do
        delete admin_category_path id: category

        expect(response).to have_http_status :redirect
        expect(Category.last).to be_nil
      end
    end
  end
end
