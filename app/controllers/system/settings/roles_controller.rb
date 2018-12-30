class System::Settings::RolesController < OwnerRequiredController

  def index
    @roles = Role.where(organization_id: current_organization_id).order(:title).page(params[:page])
  end

  def new
    @role = Role.new
  end

  def create
    result = System::Settings::Roles::Create.call(params: role_params,
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
    @role = Role.find params[:id]
  end

  def update
    @role = Role.find params[:id]

    result = System::Settings::Roles::Update.call(params: role_params,
                                                  role: @role)

    if result.success?
      flash[:success] = result.success

      redirect_to system_settings_roles_path
    else
      flash[:error] = result.error
      render 'edit'
    end
  end

  def destroy
    role = Role.find params[:id]
    result = System::Settings::Roles::Destroy.call(role: role)

    if result.success?
      flash[:success] = result.success
    else
      flash[:error] = result.error
    end

    redirect_to system_settings_roles_path
  end

  private

  def role_params
    params.require(:role).permit(:title)
  end

end
