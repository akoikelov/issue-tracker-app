# frozen_string_literal: true

class System::Employees::AcceptInvite < BaseInteractor
  def call
    invite = Invite.find_by token: params[:token]
    error_msg = nil

    if invite.present?
      if invite.email != user.email
        error_msg = 'This invite does not belong to you'
      elsif invite.expires_at - Date.today < 0
        error_msg = 'Your invite has expired'
      elsif invite.organization.nil?
        error_msg = 'Organization does not exist'
      else
        organization = invite.organization
        employee = organization.employees.build(user: user,
                                                role: invite.role)

        unless employee.save
          error_msg = 'Could not to accept invite'
        end
      end
    else
      error_msg = 'Invite not found'
    end

    if error_msg.nil?
      context.success = 'Invite successfully accepted!'
    else
      context.fail!(error: error_msg)
    end
  end
end
