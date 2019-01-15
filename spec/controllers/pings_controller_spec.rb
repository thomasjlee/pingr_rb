require 'rails_helper'

RSpec.describe PingsController, type: :controller do
  describe 'index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end
  end
end
