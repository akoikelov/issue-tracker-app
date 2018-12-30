class System::EmployeesController < OwnerRequiredController

  def index
    @employees = Employee.where(organization_id: current_organization_id).page(params[:page])
  end

  def new
    @invite = Invite.new
    @current_org_id = current_organization_id
  end

  def invite

  end

end