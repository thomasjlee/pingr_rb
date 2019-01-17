require 'rails_helper'

RSpec.feature "Users", type: :feature do
  it 'views all registered users' do
    user_one = FactoryBot.create(:user)
    user_two = FactoryBot.create(:user)

    visit users_path

    expect(page).to have_content user_one.email
    expect(page).to have_content user_two.email
  end
end
