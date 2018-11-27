module Organizations
  class Create
    include Interactor

    def call
      organization = Organization.new(context.params)
      organization.owner = context.user

      if organization.save
        organization.employees.create(user: context.user)

        context.success = "An organization created!"
        context.organization = organization
      else
        context.fail!
      end
    end
  end
end
