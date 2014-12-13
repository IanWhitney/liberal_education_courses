require "ostruct"
require_relative "../../app/models/search_parameter"

RSpec.describe MatchAttributeValue do
  describe "all?" do
    it "is false" do
      it = MatchAttributeValue.new(:other, rand)
      expect(it.all?).to be_falsey
    end
  end

  describe "match?" do
    describe "given a target with an attribute that matches the Parameter's attribute" do
      let(:target) { OpenStruct.new(search_attr: "search_value") }
      let(:value) { "search_value" }
      let(:subject) { MatchAttributeValue.new(:search_attr, value) }

      it "returns true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "given a target with an attribute that does not match the Parameter's attribute" do
      let(:target) { OpenStruct.new(search_attr: "other_value") }
      let(:value) { "search_value" }
      let(:subject) { MatchAttributeValue.new(:search_attr, value) }

      it "returns true" do
        expect(subject.match?(target)).to be_falsey
      end
    end
  end
end

RSpec.describe FindAll do
  describe "all?" do
    it "is true" do
      it = FindAll.new(:other, rand)
      expect(it.all?).to be_truthy
    end
  end

  describe "match?" do
    it "is true" do
      it = FindAll.new(:other, rand)
      expect(it.match?(rand)).to be_truthy
    end
  end
end
