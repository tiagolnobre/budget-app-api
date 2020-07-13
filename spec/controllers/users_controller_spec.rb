# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:resource) { JSON.parse(response.body) }

  describe 'on GET to :show' do
    before do
      request.headers['HTTP_AUTHORIZATION'] = JsonWebToken.encode(user_id: user.id)
    end

    context 'with existing user' do
      let!(:user) { create(:user) }

      it 'responds with success' do
        get :show, params: {}
        expect(response).to have_http_status(:success)
        expect(resource['name']).to eq(user.name)
        expect(resource['email']).to eq(user.email)
      end
    end
  end
end
