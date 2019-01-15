require 'rails_helper'

RSpec.feature "Pings", type: :feature do
  context 'as an authenticated user' do
    before { @user = FactoryBot.create(:user) }

    scenario 'views unread pings' do
      ping = FactoryBot.create(:ping, recipient: @user)
      visit pings_path(as: @user)
      expect(page).to have_content ping.pinger.email
    end
  end
end
