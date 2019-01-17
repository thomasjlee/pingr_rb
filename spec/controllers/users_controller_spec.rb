require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'index' do
    context 'as an authenticated user' do
      it 'returns a 200 response' do
        sign_in_as(FactoryBot.create(:user))
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context 'as a visitor' do
      it 'returns a 200 response' do
        get :index
        expect(response).to have_http_status '200'
      end
    end
  end
end
