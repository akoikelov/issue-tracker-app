require 'rails_helper'

RSpec.describe Organizations::Create, type: :interactor do
  describe 'Create an organization' do
    let(:user) {create(:user)}
    let(:valid_params) do
      {
        title: 'test org',
        logo: get_test_img
      }
    end

    it 'when we pass all data, it returns success' do
      context = Organizations::Create.call(params: valid_params, user: user)
      expect(context.success?).to eq true

    end

    it 'when it creates an organization, it should add employee' do
      context = Organizations::Create.call(params: valid_params, user: user)
      expect(context.success?).to eq true
      expect(context.organization.employees.count).to eq 1
    end

    it 'when we pass empty title, it returns false' do
      params = {
        title: '',
        logo: get_test_img
      }
      context = Organizations::Create.call(params: params, user: user)
      expect(context.success?).to eq false
    end
  end
end
