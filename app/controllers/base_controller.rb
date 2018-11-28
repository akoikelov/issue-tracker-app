class BaseController < ApplicationController

  layout 'application'

  before_action :check_organization

  private

  def check_organization
    redirect_to new_organization_path unless belongs_to_organization?
  end

  def belongs_to_organization?
    if session[:bto].nil?
      session[:bto] = current_user.organization.present? || current_user.employees.count > 0
    end

    session[:bto]
  end
end