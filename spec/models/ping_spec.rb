require 'rails_helper'

RSpec.describe Ping, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:ping)).to be_valid
  end

  it 'is invalid without a pinger' do
    ping = FactoryBot.build(:ping, pinger_id: nil)
    ping.valid?
    expect(ping.errors[:pinger_id]).to include "can't be blank"
  end

  it 'is invalid without a recipient' do
    ping = FactoryBot.build(:ping, recipient_id: nil)
    ping.valid?
    expect(ping.errors[:recipient_id]).to include "can't be blank"
  end

  it 'belongs to a pinger' do
    association = described_class.reflect_on_association(:pinger)
    expect(association.class_name).to eq 'User'
    expect(association.macro).to eq :belongs_to
  end

  it 'belongs to a recipient' do
    association = described_class.reflect_on_association(:recipient)
    expect(association.class_name).to eq 'User'
    expect(association.macro).to eq :belongs_to
  end
end
