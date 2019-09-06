require 'rails_helper'

RSpec.describe Organizations::Choose, type: :interactor do
  describe 'Choose an organization' do
    it 'When we choose valid organization we belong to, it returns true' do
      organization = create(:organization)

      active_user = create(:user, 
                             email: 'otherfake@mail.com'
                           )
      organization.employees.create!(user: active_user)

      params = {
        id: organization.id
      }
      context = Organizations::Choose.call(params: params, user: active_user)

      expect(context.success?).to eq true
    end

    it 'When we choose invalid organization we DONT belong to, it returns false' do
      organization = create(:organization)
      active_user = create(:user,
                           email: 'otherfake@mail.com'
      )

      params = {
        id: organization.id
      }
      context = Organizations::Choose.call(params: params, user: active_user)

      expect(context.success?).to eq false
      expect(context.error).to eq 'You have chosen an invalid organization!'
    end

    it 'When we choose valid organization we belong to, it returns id of organization' do
      organization = create(:organization)
      active_user = create(:user,
                           email: 'otherfake@mail.com'
      )
      organization.employees.create!(user: active_user)

      params = {
          id: organization.id
      }
      context = Organizations::Choose.call(params: params, user: active_user)

      expect(context.success?).to eq true
      expect(context.chosen_organization_id).to eq organization.id
    end

    it 'When we choose own organization we belong to, it returns chosen_organization_owner = true' do
      active_user = create(:user,
                           email: 'otherfake@mail.com'
      )
      organization = create(:organization, user: active_user)
      organization.employees.create!(user: active_user)

      params = {
          id: organization.id
      }
      context = Organizations::Choose.call(params: params, user: active_user)

      expect(context.success?).to eq true
      expect(context.chosen_organization_owner).to eq true
    end

  end
end
