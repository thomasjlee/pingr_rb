require 'rails_helper'

RSpec.feature "Users", type: :feature do
  it 'renders all users' do
    user_one = FactoryBot.create(:user)
    user_two = FactoryBot.create(:user)

    visit users_path

    expect(page).to have_content user_one.email
    expect(page).to have_content user_two.email
  end

  context 'as an authenticated user' do
    it 'renders all users except current user' do
      current_user = FactoryBot.create(:user)
      another_user = FactoryBot.create(:user)

      visit users_path(as: current_user)

      expect(page).to have_content another_user.email
      expect(page).to_not have_content current_user.email
    end
  end
end
