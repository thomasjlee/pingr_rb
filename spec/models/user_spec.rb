require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'can have many pings' do
    association = described_class.reflect_on_association(:pings)
    expect(association.macro).to eq :has_many
  end
end
