require 'rails_helper'

RSpec.describe PingsController, type: :controller do
  describe 'index' do
    context 'as an authenticated user' do
      it 'returns a 200 response' do
        sign_in_as(FactoryBot.create(:user))
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context 'as a visitor' do
      it 'returns a 302 response' do
        get :index
        expect(response).to have_http_status '302'
      end
    end
  end

  describe 'archive' do
    context 'as an authenticated user' do
      it 'returns a 200 response' do
        sign_in_as(FactoryBot.create(:user))
        get :archive
        expect(response).to have_http_status '200'
      end
    end

    context 'as a visitor' do
      it 'returns a 302 response' do
        get :archive
        expect(response).to have_http_status '302'
      end
    end
  end
end
