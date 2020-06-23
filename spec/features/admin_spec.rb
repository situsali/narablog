RSpec.describe 'Admin page', type: :feature do
  let(:admin_user) { FactoryBot.create :admin_user }

  context 'when admin user is confirmed' do
    it 'can visit to /admin page' do
      visit new_user_session_path

      fill_in 'user_email', with: admin_user.email
      fill_in 'user_password', with: 'Password'
      click_on 'Enter'

      visit admin_root_path
      expect(page).to have_current_path admin_root_path
      expect(page).to have_content 'Dashboard'

      # simulate logout
      find('.navbar-item').hover
      click_on 'Logout'
      expect(page).to have_current_path root_path
    end
  end

  context 'when admin user is not confirmed' do
    it 'returns 404 not found'do
      admin_user = FactoryBot.create :user, isadmin: true

      visit new_user_session_path

      fill_in 'user_email', with: admin_user.email
      fill_in 'user_password', with: 'Password'
      click_on 'Enter'

      visit admin_root_path
      expect(page).not_to have_content 'Dashboard'
    end
  end

  context 'when user is not admin' do
    it 'returns 404 not found'do
      user = FactoryBot.create :user
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'Password'
      click_on 'Enter'

      visit admin_root_path
      expect(page).not_to have_content 'Dashboard'
    end
  end
end
