require 'spec_helper'

describe ExampleController do
  describe "GET #index" do
    it "shows the version info" do
      get :index

      parsed_response = JSON.parse(response.body)
      parsed_response['version'].should == '3.2.19'
    end

    it "has a max-age of 10 minutes" do
      get :index

      response.headers['Cache-Control'].should == "max-age=600, public"
    end

    it 'has a 200 status' do
      get :index

      response.status.should == 200
    end
  end
end