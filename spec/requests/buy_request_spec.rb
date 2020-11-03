require 'rails_helper'

RSpec.describe "Buys", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/buy/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /done" do
    it "returns http success" do
      get "/buy/done"
      expect(response).to have_http_status(:success)
    end
  end

end
