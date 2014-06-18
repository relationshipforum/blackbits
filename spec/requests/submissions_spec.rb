require 'rails_helper'

RSpec.describe "Submissions", :type => :request do
  describe "GET /submissions" do
    it "works! (now write some real specs)" do
      get submissions_path
      expect(response.status).to be(200)
    end
  end
end
