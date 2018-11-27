# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    result = Organizations::Create.call(
      params: organization_params,
      user: current_user
    )

    if result.success?
      session[:bto] = true
      flash[:success] = result.success

      redirect_to root_path
    else
      render 'new'
    end

  end

  private

  def organization_params
    params.require(:organization).permit(:title, :logo)
  end
end
