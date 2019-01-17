require 'rails_helper'

RSpec.feature "Pings", type: :feature do
  context 'as an authenticated user' do
    before { @user = FactoryBot.create(:user) }

    it 'views only unread pings' do
      unread_ping = FactoryBot.create(:ping, recipient: @user)
      read_ping = FactoryBot.create(:ping, recipient: @user, read_at: DateTime.now)

      visit pings_path(as: @user)

      expect(page).to have_content unread_ping.pinger.email
      expect(page).to_not have_content read_ping.pinger.email
    end

    it 'views only read pings' do
      unread_ping = FactoryBot.create(:ping, recipient: @user)
      read_ping = FactoryBot.create(:ping, recipient: @user, read_at: DateTime.now)

      visit archive_pings_path(as: @user)

      expect(page).to have_content read_ping.pinger.email
      expect(page).to_not have_content unread_ping.pinger.email
    end
  end
end
