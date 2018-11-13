require "test_helper"

describe AssignmentsController do
  it "should get index" do
    get assignments_index_url
    value(response).must_be :success?
  end

end
