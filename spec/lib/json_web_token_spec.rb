require "rails_helper"
require "./lib/json_web_token"

RSpec.describe JsonWebToken do
  let(:user) { create(:user) }
  let(:jwt_token) { described_class.encode(user_id: user.id) }
  describe ".encode" do
    it "returns a 115 character string" do
      expect(jwt_token.length).to be_between(114, 117)
    end
  end

  describe ".decode" do
    it "decodes a JWT with the appropriate keys" do
      decoded = described_class.decode(jwt_token)
      expect(decoded[:user_id]).to eq(user.id)
      expect(Time.at(decoded[:expiration])).to be_within(2.seconds).of(1.week.from_now)
    end
  end
end
