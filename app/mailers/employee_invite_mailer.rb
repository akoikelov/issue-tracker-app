class EmployeeInviteMailer < ApplicationMailer

  default from: ENV['MAILER_FROM_EMAIL']

  def invite
    @invite = params[:invite]
    @subject = "SimpleIssueTracker: Invite from organization #{@invite.organization.title}"

    mail(to: @invite.email, subject: @subject)
  end
end
