require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a valid user' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  describe 'associations' do
    it { should have_many(:favorite_movies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
