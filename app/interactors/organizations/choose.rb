class Organizations::Choose < BaseInteractor

  def call
    id = params[:id]

    if user.belongs_to_organization?(id)
      context.chosen_organization_id = id
      context.chosen_organization_owner = user.is_organization_owner?(id)
    else
      context.fail!(error: 'You have chosen an invalid organization!')
    end

  end

end


