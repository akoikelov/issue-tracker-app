# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create; end
end
