RSpec.describe PostCategory, type: :model do
  describe 'Validates of post and category' do
    context 'when post is not set' do
      it 'fails to create a post_category' do
        pc = FactoryBot.build :post_category, post: nil
        expect(pc).to be_invalid
        expect(pc.errors.messages[:post].size).to be 1
      end
    end

    context 'when category is not set' do
      it 'fails to create a post_category' do
        pc = FactoryBot.build :post_category, category: nil
        expect(pc).to be_invalid
        expect(pc.errors.messages[:category].size).to be 1
      end
    end
  end
end
