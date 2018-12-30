class System::Employees::CreateInvite < BaseInteractor

  def call
    organization = Organization.find current_org_id
    email = params[:email]
    resend = params[:resend] == '1'
    employee_exists = organization.employee_users.exists?(email: email)
    check_invite = Invite.find_by(email: email, organization: organization)
    user_exists = User.exists?(email: email)
    error_msg = nil

    if employee_exists
      error_msg = 'Employee with a given email already exists'
    elsif check_invite.present? and not resend
      error_msg = 'Invite to a given email already sent'
    elsif not user_exists
      error_msg = 'User with a given email does not exist in the system'
    end

    if error_msg.nil?
      if resend and check_invite.present?
        check_invite.destroy
      end

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
