require_relative "../../app/models/search_parameter"

RSpec.describe SearchParameter do
  describe "all?" do
    it "is all if the attribute is :all"
    it "is not all if the attribute is not :all"
  end
end
