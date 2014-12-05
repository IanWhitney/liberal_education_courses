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
end
