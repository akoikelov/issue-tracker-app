class System::EmployeesController < OwnerRequiredController

  def index
    @employees = Employee.where(organization_id: current_organization_id).page(params[:page])
  end

  def new
    @invite = Invite.new
    @current_org_id = current_organization_id
  end

  def invite
    result = System::Employees::InviteEmployee.call(params: invite_params,
                                                    current_org_id: current_organization_id)

    if result.success?
      flash[:success] = result.success
      redirect_to system_employees_path
    else
      flash[:error] = result.error
      redirect_to new_system_employee_path
    end

  end

  private

  def invite_params
    params.require(:invite).permit(:email, :role_id)
  end

end