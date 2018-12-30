class System::Settings::Roles::Destroy
  include Interactor

  def call
    if role.destroy
      context.success = 'Role successfully deleted!'
    else
      context.fail!(error: 'Could not delete role!')
    end
  end

  def role
    context.role
  end
end
