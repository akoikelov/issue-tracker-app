class BaseInteractor
  include Interactor

  def params
    context.params
  end

  def user
    context.user
  end

  def current_org_id
    context.current_org_id
  end

end