class System::Employees::InviteEmployee < BaseInteractor

  def call
    organization = Organization.find current_org_id
    email = params[:email]

    employee_exists = organization.employee_users.exists?(email: email)
    invite_already_sent = Invite.exists?(email: email, organization: organization)
    error_msg = nil

    if employee_exists
      error_msg = 'Employee with a given email already exists'
    elsif invite_already_sent
      error_msg = 'Invite to a given email already sent'
    end

    if error_msg.nil?
      invite = Invite.new(params)
      invite.organization = organization

      if invite.save
        EmployeeInviteMailer.with(invite: invite).invite.deliver_later
        context.success = 'Invite to a given email successfully sent'
      else
        context.fail!(error: 'Could not send invite!')
      end
    else
      context.fail!(error: error_msg)
    end

  end
end
