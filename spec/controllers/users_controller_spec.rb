# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:resource) { JSON.parse(response.body) }

  # GET /users/me
  describe "on GET to :show" do
    before do
      request.headers["HTTP_AUTHORIZATION"] = JsonWebToken.encode(user_id: user.id)
    end

    context "with existing user" do
      let!(:user) { create(:user) }

      it "responds with success" do
        get :show, params: {}
        expect(response).to have_http_status(:success)
        expect(resource["name"]).to eq(user.name)
        expect(resource["email"]).to eq(user.email)
      end
    end
  end

  # POST /users
  describe "on POST to :create" do
    let(:email) { "qwerty@mail.com" }
    let(:user) { User.find_by(email: email) }
    let(:params) do
      {name: "qwerty",
       username: "qwerty",
       email: email,
       password: "123qweasd"}
    end

    context "with valid params" do
      it "responds with success" do
        post :create, params: params
        expect(response).to have_http_status(:success)
        expect(resource["name"]).to eq(user.name)
        expect(resource["email"]).to eq(user.email)
      end
    end

    context "with invalid params" do
      %i[username email password].each do |param|
        context "when missing :#{param}" do
          it "responds with 422" do
            post :create, params: params.except(param)
            expect(response).to have_http_status(:unprocessable_entity)
            expect(resource["errors"]).to include("#{param.capitalize} can't be blank")
          end
        end
      end
    end

    context "with existing :email" do
      let!(:user) { create(:user) }

      it "responds with 422" do
        post :create, params: params.merge(email: user.email)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(resource["errors"]).to include("Email has already been taken")
      end
    end

    context "with existing :username" do
      let!(:user) { create(:user) }

      it "responds with 422" do
        post :create, params: params.merge(username: user.username)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(resource["errors"]).to include("Username has already been taken")
      end
    end
  end
end
