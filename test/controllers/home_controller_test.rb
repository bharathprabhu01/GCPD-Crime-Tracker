require "test_helper"

describe HomeController do
  it "should get index" do
    get home_index_url
    value(response).must_be :success?
  end

  it "should get about" do
    get home_about_url
    value(response).must_be :success?
  end

  it "should get contact" do
    get home_contact_url
    value(response).must_be :success?
  end

  it "should get privacy" do
    get home_privacy_url
    value(response).must_be :success?
  end

  it "should get search" do
    get home_search_url
    value(response).must_be :success?
  end

end
