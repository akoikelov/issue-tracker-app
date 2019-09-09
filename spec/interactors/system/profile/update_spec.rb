require 'rails_helper'

RSpec.describe System::Profile::Update, type: :interactor do
  include FixtureHelper

  let(:user) {create(:user)}

  describe 'Profile update' do
    it 'When we pass valid data, user updates' do
      new_first_name = 'New first name'
      new_last_name = 'New last name'
      new_lat = 50.0
      new_lng = 10.0

      context = System::Profile::Update.call(user: user, params: {
          first_name: new_first_name, last_name: new_last_name,
          lat: new_lat, lng: new_lng, avatar: get_test_img
      })

      expect(context.success?).to eq true

      updated_user = User.find(user.id)

      expect(updated_user.first_name).to eq new_first_name
      expect(updated_user.last_name).to eq new_last_name
      expect(updated_user.lat).to eq new_lat
      expect(updated_user.lng).to eq new_lng
      expect(updated_user.avatar.present?).to eq true

    end
  end
end
