require_relative "../../app/models/search_parameters"
require_relative "../../app/models/query_parser"
require_relative "../../app/models/search_parameter"

RSpec.describe SearchParameter do
  describe "parse" do
    describe "with a query_string" do
      it "creates a collection of SearchParameter instances"
      it "returns false to all?"
    end
    describe "without a query_string" do
      it "creates a single :all SearchParameter"
      it "returns true to all?"
    end
  end
end
