require "test_helper"

describe CrimesController do
  it "should get index" do
    get crimes_index_url
    value(response).must_be :success?
  end

  it "should get new" do
    get crimes_new_url
    value(response).must_be :success?
  end

end
