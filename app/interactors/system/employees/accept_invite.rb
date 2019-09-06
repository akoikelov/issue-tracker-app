# frozen_string_literal: true

class System::Employees::AcceptInvite < BaseInteractor
  def call
    invite = Invite.find_by token: params[:token]
    error_msg = nil
    invitation_accepted = false

    if invite.present?
      organization = invite.organization

      if invite.email != user.email
        error_msg = 'This invite does not belong to you'
      elsif invite.expires_at - Date.today < 0
        error_msg = 'Your invite has expired'
      elsif organization.employee_exists?(invite.email)
        error_msg = 'Employee with a given email already exists'
      else
        employee = organization.employees.build(user: user,
                                                role: invite.role)

        if employee.save
          invite.destroy
          invitation_accepted = true
        else
          error_msg = 'Could not to accept invite'
        end
      end
    else
      error_msg = 'Invite not found'
    end

    if invitation_accepted
      context.success = 'Invite successfully accepted!'
    else
      context.fail!(error: error_msg)
    end
  end
end
