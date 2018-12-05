class Organizations::Choose
  include Interactor

  def call
    id = params[:id]

    if user.belongs_to_organization?(id)
      context.chosen_organization_id = id
    else
      context.fail!(error: 'You have chosen an invalid organization!')
    end

  end

  def params
    context.params
  end

  def user
    context.user
  end

end


