class IndexController < ApplicationController
  include OrganizationMixin

  layout 'application'

  def index; end

end
