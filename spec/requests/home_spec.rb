require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "should respond successfully" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "should respond successfully with charmander" do
      VCR.use_cassette("charmander_success") do
        get root_path(q: "charmander")
        expect(response).to have_http_status(200)
      end
    end
  end
end
