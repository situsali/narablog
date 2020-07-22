RSpec.describe Category, type: :model do
  describe '.name' do
    context 'when name is not set' do
      it 'fails to create category' do
        category = FactoryBot.build :category, name: nil
        expect(category).to be_invalid
        expect(category.errors.messages[:name].size).to be 1
      end
    end

    context 'when name is set' do
      it 'successfully to create a category' do
        category = FactoryBot.create :category
        expect(category).to be_valid
        expect(category.name).to be_present
      end
    end
  end

  describe '.slug' do
    context 'when slug is not set' do
      it "don't generate if name is blank" do
        category = FactoryBot.build :category, name: nil, slug: nil
        expect(category).to be_invalid
        expect(category.errors.messages[:name].size).to be 1
        expect(category.errors.messages[:slug].size).to be 2
      end

      it 'auto generate slug by name' do
        category = FactoryBot.create :category, slug: nil
        expect(category).to be_valid
        expect(category.slug).to be_present
      end
    end

    context 'when slug is set' do
      it 'successfully to create a category' do
        category = FactoryBot.create :category
        expect(category).to be_valid
        expect(category.slug).to be_present
      end

      it 'fails if slug includes space or some special characters' do
        category = FactoryBot.build :category, slug: 'this is slug!'
        expect(category).to be_invalid
        expect(category.errors.messages[:slug].size).to be 1
      end
    end
  end

  describe '.posts' do
    let(:post) { FactoryBot.create :post }

    context 'when posts are not set' do
      it 'successfully to create a category' do
        category = post.categories.first
        category.posts.clear
        category.save

        expect(category).to be_valid
      end
    end

    describe 'when destroying a category' do
      context 'when category has a post' do
        it 'fails and raise error ActiveRecord::InvalidForeignKey' do
          category = Category.find post.categories.first.id
          expect { category.destroy }.to raise_error ActiveRecord::InvalidForeignKey
          expect(Category.any?).to be true
        end
      end

      context 'when category has not a post' do
        it 'successfully to destroy' do
          category = Category.find post.categories.first.id
          post.destroy
          category.destroy
          expect(Category.any?).to be false
        end
      end
    end
  end
end
