require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:favorite_movies) }
    it { should have_many(:users).through(:favorite_movies) }
  end
end
