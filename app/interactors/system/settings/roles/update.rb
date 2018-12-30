class System::Settings::Roles::Update < BaseInteractor

  def call
    if role.update_attributes(params)
      context.success = 'Role successfully updated!'
    else
      context.fail!(error: 'Could not update role!')
    end
  end

  private

  def role
    context.role
  end
end
