require "test_helper"

describe UnitsController do
  it "should get index" do
    get units_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get units_show_url
    value(response).must_be :success?
  end

  it "should get new" do
    get units_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get units_edit_url
    value(response).must_be :success?
  end

end
