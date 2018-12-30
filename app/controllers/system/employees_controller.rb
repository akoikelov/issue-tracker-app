class System::EmployeesController < OwnerRequiredController

  def index
    @employees = Employee.where(organization_id: current_organization_id).page(params[:page])
  end

end