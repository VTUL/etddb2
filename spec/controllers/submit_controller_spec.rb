require_relative '../spec_helper'

describe SubmitController do

  describe "GET 'index_etd'" do
    it "should be successful" do
      get 'index_etd'
      response.should be_success
    end
  end

#  describe "GET 'show_etd'" do
#    it "should be successful" do
#      get 'show_etd', :id=>'18'
#      #response.should be_success
#      response.should have_selector("id",:content=>"18")
#    end
#  end

end

