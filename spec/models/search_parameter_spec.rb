require "ostruct"
require_relative "../../app/models/search_parameter"

RSpec.describe SearchParameter do
  describe "all?" do
    it "is all if the attribute is :all" do
      it = SearchParameter.new(:all, rand)
      expect(it.all?).to be_truthy
      expect(it.attribute).to eq(:all)
    end

    it "is not all if the attribute is not :all" do
      it = SearchParameter.new(:other, rand)
      expect(it.all?).to be_falsey
      expect(it.attribute).to eq(:other)
    end
  end

  describe "match?" do
    describe "given a target with an attribute that matches the Parameter's attribute" do
      let(:target) { OpenStruct.new(search_attr: "search_value") }
      let(:value) { "search_value" }
      let(:subject) { SearchParameter.new(:search_attr, value) }

      it "returns true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "given a target with an attribute that does not match the Parameter's attribute" do
      let(:target) { OpenStruct.new(search_attr: "other_value") }
      let(:value) { "search_value" }
      let(:subject) { SearchParameter.new(:search_attr, value) }

      it "returns true" do
        expect(subject.match?(target)).to be_falsey
      end
    end
  end
end
