require 'rails_helper'

RSpec.describe "Creditcards", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/creditcard/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/creditcard/show"
      expect(response).to have_http_status(:success)
    end
  end

end
