class BaseInteractor
  include Interactor

  def params
    context.params
  end

  def user
    context.user
  end

end