require 'rails_helper'

RSpec.describe System::Employees::AcceptInvite, type: :interactor do
  describe 'Accept invitation' do
    it 'When we opens an invitation link with an non-existing token , it fails' do
      params = {
          token: "invalid_token"
      }

      context = System::Employees::AcceptInvite.call(params: params)

      expect(context.success?).to eq false
      expect(context.error).to eq 'Invite not found'
    end
    it 'When user opens an invite which does not belong to him, it fails' do
      owner = create(:user, email: 'owner@localhost')
      organization = create(:organization, user: owner)
      role = create(:role, organization: organization)

      invite = create(:invite, organization: organization, role: role)
      user = create(:user)

      params = {
          token: invite.token
      }

      context = System::Employees::AcceptInvite.call(params: params, user: user)

      expect(context.success?).to eq false
      expect(context.error).to eq 'This invite does not belong to you'

    end
    it 'When user opens an invite which has been expired, it fails' do
      owner = create(:user, email: 'owner@localhost')
      organization = create(:organization, user: owner)
      role = create(:role, organization: organization)

      invite = create(:invite, organization: organization, role: role)
      user = create(:user, email: invite.email)

      invite.expires_at = Date.yesterday
      invite.save

      params = {
          token: invite.token
      }

      context = System::Employees::AcceptInvite.call(params: params, user: user)

      expect(context.success?).to eq false
      expect(context.error).to eq 'Your invite has expired'
    end
    it 'When user opens an invite and there is already an employee with the given email, it fails' do
      owner = create(:user, email: 'owner@localhost')
      organization = create(:organization, user: owner)
      role = create(:role, organization: organization)

      invite = create(:invite, organization: organization, role: role)
      user = create(:user, email: invite.email)

      organization.employees.create(user: user, role: role)

      params = {
          token: invite.token
      }

      context = System::Employees::AcceptInvite.call(params: params, user: user)

      expect(context.success?).to eq false
      expect(context.error).to eq 'Employee with a given email already exists'
    end
    it 'When user opens a valid invite, this user will be added to employees list and invite will be destroyed' do
      owner = create(:user, email: 'owner@localhost')
      organization = create(:organization, user: owner)
      role = create(:role, organization: organization)

      invite = create(:invite, organization: organization, role: role)
      user = create(:user, email: invite.email)

      params = {
          token: invite.token
      }

      context = System::Employees::AcceptInvite.call(params: params, user: user)

      expect(context.success?).to eq true
      expect(Employee.find_by(organization: organization, user: user).present?).to eq true
      expect(Invite.find_by(id: invite.id).nil?).to eq true

    end

  end
end
