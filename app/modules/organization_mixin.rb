# frozen_string_literal: true

module OrganizationMixin

  def self.included(base)
    base.before_action :check_organization
  end

  private

  def check_organization
    unless belongs_to_organization?
      redirect_to organization_path
    end
  end

  def belongs_to_organization?
    unless session[:bto].nil?
      session[:bto] = if !current_user.organization.nil? || current_user.employees.count > 0
                      end
    end

    session[:bto]
  end
end
