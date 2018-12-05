class System::Profile::Update < BaseInteractor

  def call
    if user.update_attributes(params)
      context.success = 'Profile successfully updated!'
    else
      context.fail!(error: 'Could not update profile!')
    end
  end

end
