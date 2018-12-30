class System::Settings::Roles::Create < BaseInteractor

  def call
    role = Role.new(params)
    role.organization_id = current_org_id

    if role.save
      context.success = 'Role successfully saved!'
    else
      context.fail!(error: 'Could not create role')
    end
  end
end
