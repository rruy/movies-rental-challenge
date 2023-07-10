require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a valid user' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  describe 'associations' do
    it { should have_many(:favorite_movies) }
    it { should have_many(:favorites).through(:favorite_movies).source(:movie) }
    it { should have_many(:rentals) }
    it { should have_many(:rented).through(:rentals).source(:movie) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
