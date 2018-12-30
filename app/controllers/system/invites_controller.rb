class System::InvitesController < ApplicationController

  def accept
    result = System::Employees::AcceptInvite.call(params: invite_params,
                                                  user: current_user)

    if result.success?
      flash[:success] = result.success
    else
      flash[:error] = result.error
    end

  end

  def invite_params
    params.permit(:token)
  end

end