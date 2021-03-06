RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create :user }

  describe 'validates' do
    context '#email' do
      it 'valid when email is present' do
        expect(user.email).to be_present
        expect(user).to be_valid
      end

      it 'invalid when email is not present' do
        user.update(email: nil)
        expect(user.email).to be_nil
        expect(user).to be_invalid
      end
    end

    context '#username' do
      it 'valid when username is present' do
        expect(user.username).to be_present
        expect(user).to be_valid
      end

      it 'invalid when username is not present' do
        user.update(username: nil)
        expect(user.username).to be_nil
        expect(user).to be_invalid
      end

      it 'miminum 5 characters' do
        expect(user.username.length).to be >= 5
        expect(user.username.length).to be <= 128

        user.update(username: 'john')
        expect(user).to be_invalid

        user.update(username: 'john' * 50)
        expect(user).to be_invalid
      end

      it 'invalid format using space or special characters' do
        user.update(username: 'john doe!')
        expect(user).to be_invalid
      end
    end

    context '#password' do
      it 'minimum 8 and maximum 128 characters' do
        expect(user.password.length).to be >= 8
        expect(user.password.length).to be <= 128

        user.update(password: 'passwo')
        expect(user).to be_invalid

        user.update(password: 'pass' * 50)
        expect(user).to be_invalid
      end
    end
  end
end
