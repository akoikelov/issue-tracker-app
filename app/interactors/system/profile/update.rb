class System::Profile::Update
  include Interactor

  def call
    if user.update_attributes(params)
      context.success = 'Profile successfully updated!'
    else
      context.fail!(error: 'Could not update profile!')
    end
  end

  def params
    context.params
  end

  def user
    context.user
  end

end
