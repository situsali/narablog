RSpec.describe Post, type: :model do
  describe '.user' do
    context 'when user is not assign' do
      it 'fails to create a post' do
        post = FactoryBot.build :post, user: nil
        expect(post).to be_invalid
        expect(post.errors.messages[:user].size).to be 1
      end
    end

    context 'when user is assign' do
      it 'successfully to create a post' do
        post = FactoryBot.create :post
        expect(post).to be_valid
        expect(post.user).to be_present
      end
    end
  end

  describe '.title' do
    context 'when title is not set' do
      it 'fails to create post' do
        post = FactoryBot.build :post, title: nil
        expect(post).to be_invalid
        expect(post.errors.messages[:title].size).to be 1
      end
    end

    context 'when title is set' do
      it 'successfully to create a post' do
        post = FactoryBot.create :post
        expect(post).to be_valid
        expect(post.title).to be_present
      end
    end
  end

  describe '.slug' do
    context 'when slug is not set' do
      it "don't generate if title is blank" do
        post = FactoryBot.build :post, title: nil, slug: nil
        expect(post).to be_invalid
        expect(post.errors.messages[:title].size).to be 1
        expect(post.errors.messages[:slug].size).to be 1
      end

      it 'auto generate slug by title' do
        post = FactoryBot.create :post, slug: nil
        expect(post).to be_valid
        expect(post.slug).to be_present
      end
    end

    context 'when slug is set' do
      it 'successfully to create a post' do
        post = FactoryBot.create :post
        expect(post).to be_valid
        expect(post.slug).to be_present
      end

      it 'fails if slug includes space or some special characters' do
        post = FactoryBot.build :post, slug: 'this is slug!'
        expect(post).to be_invalid
        expect(post.errors.messages[:slug].size).to be 1
      end
    end
  end

  describe '.categories' do
    let(:post) { FactoryBot.create :post }

    context 'when have no one categories' do
      it 'fails to create a post' do
        post.categories.clear
        post.save

        expect(post).to be_invalid
        expect(post.errors.messages[:categories].size).to be 1
      end
    end

    context 'when categories are sets at least one' do
      it 'successfully to create a post' do
        post.categories.clear
        post.save
        expect(post).to be_invalid

        post.categories << FactoryBot.create(:category)
        post.save

        expect(post).to be_valid
      end
    end

    context 'when categories are duplicates' do
      it 'fails to set and raise error ActiveRecord::RecordInvalid' do
        category = FactoryBot.create :category

        post.categories << category
        expect(post).to be_valid

        expect { post.categories << category }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
