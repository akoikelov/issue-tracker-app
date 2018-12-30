class BaseController < ApplicationController

  layout 'application'

  before_action :check_organization_chosen

  def self.organization_owner_required!
    before_action :check_organization_owner
  end

  private

  def check_organization_chosen
    redirect_to organizations_path if session[:chosen_organization_id].nil?
  end

  def check_organization_owner
    unless current_user.is_organization_owner?(session[:chosen_organization_id])
      flash[:access_error] = 'You have no permission to see this section!'
      redirect_to system_dashboard_index_path
    end
  end

  def current_organization_id
    session[:chosen_organization_id]
  end

end