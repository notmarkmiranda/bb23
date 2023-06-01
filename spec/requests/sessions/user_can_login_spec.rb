require "rails_helper"
require "./lib/json_web_token"

RSpec.describe "User can log in", type: :request do
  let(:user) { create(:user, :with_token) }
  let(:user_params) { {email: user.email, password: password} }
  let(:token) { JsonWebToken.encode({ user_id: user.id }, user.token_expiration) }

  describe "authorized" do
    let(:password) { "password" }

    it "returns the token, expiration, email and status 200" do
      post "/auth/login", params: user_params

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response["token"]).to eq(token)
      expect(json_response["expiration"]).to eq(user.token_expiration.to_i)
    end
  end

  describe "unauthorized" do
    let(:password) { "passwordz" }

    it "returns an error with status 401" do
      post "/auth/login", params: user_params

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(401)
      expect(json_response["error"]).to eq("unauthorized")
    end
  end
end
