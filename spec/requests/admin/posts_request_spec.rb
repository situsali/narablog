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
    let(:post_category) { FactoryBot.create :category }

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
      it 'returns http redirect and success to create a post' do
        post_title = Faker::Lorem.sentence
        post admin_posts_path, params: { post: { title: post_title,
                                                 slug: '',
                                                 body: Faker::Lorem.paragraph,
                                                 category_ids: [post_category.id],
                                                 tag_ids: [],
                                                 user: admin_user } }

        article = Post.last
        expect(response).to have_http_status :redirect
        expect(article.title).to eq post_title
        expect(article.user.name).to eq admin_user.name
      end
    end

    describe 'PATCH /update' do
      it 'returns http redirect and success to update a post' do
        post_title = Faker::Lorem.sentence
        patch admin_post_path id: article,
                              params: { post: { title: post_title,
                                                body: Faker::Lorem.paragraph,
                                                slug: 'edited',
                                                category_ids: [post_category.id],
                                                tag_ids: [],
                                                user: admin_user } }

        article.reload
        expect(response).to have_http_status :redirect
        expect(article.title).to eq post_title
        expect(article.slug).to eq 'edited'
      end
    end

    describe 'PUT /update' do
      it 'returns http redirect and success to update a post' do
        post_title = Faker::Lorem.sentence
        put admin_post_path id: article,
                            params: { post: { title: post_title,
                                              body: Faker::Lorem.paragraph,
                                              slug: 'edited',
                                              category_ids: [post_category.id],
                                              tag_ids: [],
                                              user: admin_user } }

        article.reload
        expect(response).to have_http_status :redirect
        expect(article.title).to eq post_title
        expect(article.slug).to eq 'edited'
      end
    end

    describe 'DELETE /destroy' do
      it 'returns http redirect and success to delete a post' do
        delete admin_post_path id: article
        expect(response).to have_http_status :redirect
        expect(Post.last).to be_nil
      end
    end
  end
end
