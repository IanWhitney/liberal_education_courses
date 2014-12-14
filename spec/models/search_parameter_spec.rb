require "ostruct"
require_relative "../../app/models/search_parameter"
require_relative "../../app/models/matchers/match_all"
require_relative "../../app/models/matchers/match_attribute"
require_relative "../../app/models/matchers/match_no_attribute"
require_relative "../../app/models/matchers/match_attribute_value"

RSpec.describe SearchParameter do
  describe "all?" do
    it "is false" do
      it = SearchParameter.new(:other, rand)
      expect(it.all?).to be_falsey
    end
  end

  describe "match?" do
    it "is false" do
      value = rand
      target = OpenStruct.new(other: value)
      it = SearchParameter.new(:other, value)
      expect(it.match?(target)).to be_falsey
    end
  end

  describe "build_me?" do
    it "is true" do
      it = SearchParameter.build_me?(rand, rand)
      expect(it).to be_truthy
    end
  end

  describe "matchers" do
    it "is has self as last element " do
      it = SearchParameter.matchers
      expect(it.last).to eq(SearchParameter)
    end
  end
end
