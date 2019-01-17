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

  describe 'archives' do
    context 'as an authenticated user' do
      it 'returns a 200 response' do
        sign_in_as(FactoryBot.create(:user))
        get :archives
        expect(response).to have_http_status '200'
      end
    end

    context 'as a visitor' do
      it 'returns a 302 response' do
        get :archives
        expect(response).to have_http_status '302'
      end
    end
  end

  describe 'create' do
    context 'as an authenticated user' do
      it 'creates a ping' do
        recipient = FactoryBot.create(:recipient)
        current_user = sign_in_as(FactoryBot.create(:pinger))
        expect {
          post :create, params: { ping: { recipient_id: recipient.id, pinger: current_user } }
        }.to change(Ping, :count).by 1
      end
    end

    context 'as a visitor' do
      it 'redirects to the sign in page' do
        ping_params = FactoryBot.attributes_for(:ping)
        post :create, params: { ping: ping_params }
        expect(response).to redirect_to sign_in_path
      end

      it 'does not create a ping' do
        ping_params = FactoryBot.attributes_for(:ping)
        expect {
          post :create, params: { ping: ping_params }
        }.to change(Ping, :count).by 0
      end
    end
  end
end
