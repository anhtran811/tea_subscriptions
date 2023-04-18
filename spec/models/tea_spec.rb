require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:subscriptions).through(:tea_subscriptions) }
    it { should have_many(:customers).through(:subscriptions) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:brew_time) }
    it { should validate_presence_of(:price) }
  end
end