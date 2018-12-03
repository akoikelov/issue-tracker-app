class BaseController < ApplicationController

  layout 'application'

  before_action :check_organization_chosen

  private

  def check_organization_chosen
    redirect_to organizations_path if session[:chosen_organization_id].nil?
  end
end