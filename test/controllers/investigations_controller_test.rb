require "test_helper"

describe InvestigationsController do
  it "should get index" do
    get investigations_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get investigations_show_url
    value(response).must_be :success?
  end

  it "should get new" do
    get investigations_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get investigations_edit_url
    value(response).must_be :success?
  end

end
