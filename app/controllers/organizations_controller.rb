# frozen_string_literal: true

class OrganizationsController < ApplicationController

  def index; end

  def new
    @organization = Organization.new
  end

  def create
    result = Organizations::Create.call(
      params: organization_params,
      user: current_user
    )

    if result.success?
      session[:chosen_organization_id] = result.organization.id
      flash[:success] = result.success

      redirect_to root_path
    else
      flash[:error] = result.error
      render 'new'
    end

  end

  def choose
    result = Organizations::Choose.call(params: choose_params)

    if result.success?
      session[:chosen_organization_id] = result.chosen_organization_id
      session[:success] = result.success

      redirect_to root_path
    else
      flash[:error] = result.error
      render 'index'
    end

  end

  private

  def organization_params
    params.require(:organization).permit(:title, :logo)
  end

  def choose_params
    params.permit(:organization_id)
  end
end
