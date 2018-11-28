module Organizations
  class Create
    include Interactor

    def call
      organization = Organization.new(params)
      organization.owner = user

      if organization.save
        organization.employees.create(user: user)

        context.success = "An organization created!"
        context.organization = organization
      else
        context.fail!(error: 'Could not to create an organization!')
      end
    end

    def params
      context.params
    end

    def user
      context.user
    end

  end
end
