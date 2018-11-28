class BaseController < ApplicationController

  layout 'application'

  before_action :check_organization

  private

  def check_organization
    redirect_to new_organization_path unless belongs_to_organization?
  end

  def belongs_to_organization?
    if session[:bto].nil?
      session[:bto] = current_user.own_organization.present? || current_user.work_organizations.count > 0
    end

    session[:bto]
  end
end