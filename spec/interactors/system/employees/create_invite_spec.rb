require 'rails_helper'

RSpec.describe System::Employees::CreateInvite, type: :interactor do
  include ActiveJob::TestHelper

  let(:organization) {create(:organization)}

  describe 'Create invitation' do
    it 'When we trying to invite employee with the existing email in the organization, it fails' do
       role = create(:role, organization: organization)
       user = create(:user, email: 'invite@localhost')

       organization.employees.create(user: user, role: role)

       context = System::Employees::CreateInvite.call(params: {
           email: user.email
       }, current_org_id: organization.id)

       expect(context.success?).to eq false
       expect(context.error).to eq 'Employee with a given email already exists'

    end
    it 'When we trying to invite employee, but an invite is already sent (without resend attr set), it fails' do
      role = create(:role, organization: organization)
      user = create(:user, email: 'invite@localhost')

      Invite.create!(email: user.email, organization: organization, role: role)

      context = System::Employees::CreateInvite.call(params: {
          email: user.email, resend: '0'
      }, current_org_id: organization.id)

      expect(context.success?).to eq false
      expect(context.error).to eq 'Invite to a given email already sent'

    end
    it 'When we trying to invite employee with email which does not exist, it fails' do
      non_existing_email = 'non_existing@localhost'

      context = System::Employees::CreateInvite.call(params: {
          email: non_existing_email,
      }, current_org_id: organization.id)

      expect(context.success?).to eq false
      expect(context.error).to eq 'User with a given email does not exist in the system'

    end
    it 'When we trying to invite employee with email which does not exist, it fails' do
      non_existing_email = 'non_existing@localhost'

      context = System::Employees::CreateInvite.call(params: {
          email: non_existing_email,
      }, current_org_id: organization.id)

      expect(context.success?).to eq false
      expect(context.error).to eq 'User with a given email does not exist in the system'

    end
    it 'When we pass correct data, it creates an invite and sends an email message with invitation' do
      role = create(:role, organization: organization)
      user = create(:user, email: 'invite@localhost')

      context = System::Employees::CreateInvite.call(params: {
          email: user.email, organization: organization, role: role
      }, current_org_id: organization.id)

      expect(context.success?).to eq true
      expect(context.success).to eq 'Invite to a given email successfully sent'
      expect(Invite.find_by(email: user.email, organization: organization, role:role).present?).to eq true

      expect(enqueued_jobs.size).to eq(1)
    end
    it 'When we pass correct data and resend attr set, previous invite will be deleted' do
      role = create(:role, organization: organization)
      user = create(:user, email: 'invite@localhost')

      old_invite = Invite.create!(email: user.email, organization: organization, role: role)

      System::Employees::CreateInvite.call(params: {
          email: user.email, organization: organization, role: role, resend: '1'
      }, current_org_id: organization.id)

      expect(Invite.find_by(id: old_invite.id).nil?).to eq true

    end

  end
end
