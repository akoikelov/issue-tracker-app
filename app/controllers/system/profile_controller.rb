class System::ProfileController < BaseController

  def index
  end

  def update
    result = System::Profile::Update.call(params: profile_params,
                                          user: current_user)

    if result.success?
      flash[:success] = result.success

      redirect_to system_profile_index_path
    else
      flash[:error] = result.error
      render 'index'
    end

  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end


end
