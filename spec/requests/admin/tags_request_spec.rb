RSpec.describe "Admin::Tags", type: :request do
  context 'when user is not login' do
    it 'returns http not found' do
      get admin_tags_path
      expect(response).to have_http_status :not_found
    end
  end

  context 'when logged in user is not admin' do
    it 'returns http not found' do
      sign_in FactoryBot.create :user, :confirmed
      get admin_tags_path
      expect(response).to have_http_status :not_found
    end
  end

  context 'when admin user is logged in' do
    let(:admin_user) { FactoryBot.create :admin_user }
    let(:tag) { FactoryBot.create :tag }

    before { sign_in admin_user }

    describe 'GET /index' do
      it 'returns http success' do
        get admin_tags_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /show' do
      it 'returns http success' do
        get admin_tag_path(tag)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /edit' do
      it 'returns http success' do
        get edit_admin_tag_path id: tag
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /new' do
      it 'returns http success' do
        get new_admin_tag_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /create' do
      it 'returns http redirect and success to create a tag' do
        tag_name = Faker::Lorem.word
        post admin_tags_path, params: { tag: { name: tag_name,
                                                        slug: '',
                                                        description: '' } }

        expect(response).to have_http_status :redirect
        expect(Tag.last.name).to eq tag_name
      end
    end

    describe 'PATCH /update' do
      it 'returns http redirect and success to update a tag' do
        tag_name = Faker::Lorem.word
        patch admin_tag_path id: tag,
                                  params: { tag: { name: tag_name,
                                                        slug: 'edited',
                                                        description: '' } }

        tag.reload
        expect(response).to have_http_status :redirect
        expect(tag.name).to eq tag_name
      end
    end

    describe 'PUT /update' do
      it 'returns http redirect and success to update a tag' do
        tag_name = Faker::Lorem.word
        put admin_tag_path id: tag,
                                params: { tag: { name: tag_name,
                                                      slug: 'edited',
                                                      description: '' } }

        tag.reload
        expect(response).to have_http_status :redirect
        expect(tag.name).to eq tag_name
      end
    end

    describe 'DELETE /destroy' do
      it 'returns http redirect' do
        delete admin_tag_path id: tag

        expect(response).to have_http_status :redirect
        expect(Tag.last).to be_nil
      end
    end
  end
end
