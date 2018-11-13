require "test_helper"

describe OfficersController do
  it "should get index" do
    get officers_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get officers_show_url
    value(response).must_be :success?
  end

  it "should get new" do
    get officers_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get officers_edit_url
    value(response).must_be :success?
  end

end
