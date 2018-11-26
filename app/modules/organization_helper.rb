# frozen_string_literal: true

module OrganizationHelper
  def self.included(base)
    base.before_action :check_organization
  end

  private

  def check_organization
    unless belongs_to_organization?

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
