require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:another_user) { create(:user) }

    it 'should be true' do
      expect(user.author_of?(question)).to be_truthy
    end

    it 'should be false' do
      expect(another_user.author_of?(question)).to be_falsy
    end
  end
end
