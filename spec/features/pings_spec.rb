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

      visit archives_path(as: @user)

      expect(page).to have_content read_ping.pinger.email
      expect(page).to_not have_content unread_ping.pinger.email
    end

    it 'pings another users' do
      another_user = FactoryBot.create(:user)
      visit root_path(as: @user)
      expect { click_on "ping!" }.to change(Ping, :count).by 1
      expect(Ping.last.recipient).to eq another_user
    end

    it 'marks a ping as read' do
      pinger = FactoryBot.create(:user)
      ping = Ping.create(recipient: @user, pinger: pinger)

      visit pings_path(as: @user)

      click_on 'cool'
      expect(ping.reload.read_at).to_not be_nil
    end

    it 'marks all pings as read' do
      pinger = FactoryBot.create(:user)
      ping_one = Ping.create(recipient: @user, pinger: pinger)
      ping_two = Ping.create(recipient: @user, pinger: pinger)

      visit pings_path(as: @user)

      click_on 'all good'
      expect(page).to_not have_content ping_one.pinger.email
      expect(page).to_not have_content ping_two.pinger.email
    end
  end
end
