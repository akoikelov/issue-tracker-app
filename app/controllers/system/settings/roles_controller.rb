class System::Settings::RolesController < OwnerRequiredController

  def index
    @roles = Role.where(organization_id: current_organization_id).all
  end

  def new
    @role = Role.new
  end

  def create
    result = System::Settings::Roles::Create.call(params: role_params,
                                                  user: current_user,
                                                  current_org_id: current_organization_id)

    if result.success?
      flash[:success] = result.success

      redirect_to system_settings_roles_path
    else
      flash[:error] = result.error
      render 'new'
    end

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def role_params
    params.require(:role).permit(:title)
  end

end
