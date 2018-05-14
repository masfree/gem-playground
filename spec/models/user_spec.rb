require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123124') }
  
    context "user already has authorisation" do
      it 'returns the user' do
        user.authorization.create(provider: 'vkontakte', uid: '123124')
        expect(User.find_for_oauth(auth)).to eq(user)
      end

      it 'does not create a new user' do
        user.authorization.create(provider: 'vkontakte', uid: '123124')
        expect{ User.find_for_oauth(auth) }.to_not change(User, :count)
      end
    end

    context "user has not authorisation" do
      it 'creates new user' do
        expect{ User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end
    end
  end
end
