require_relative "../../app/models/matcher_builder"
require_relative "../../app/models/match_attribute"
require_relative "../../app/models/search_parameter"
require_relative "../../app/models/query_options"

RSpec.describe MatcherBuilder do
  let(:matcher_double) { class_double("MatchAttribute") }
  let(:param_double) { double("QueryOptions") }

  before do
    allow(SearchParameter).to receive(:matchers).and_return([matcher_double])
    allow(param_double).to receive(:search_param).and_return("test_search_param")
    allow(param_double).to receive(:search_type).and_return("test_search_type")
  end

  describe "build" do
    describe "finds a matcher to build" do
      it "builds that matcher and returns it" do
        test_return = Object.new
        expect(matcher_double).to receive(:build_me?).with(param_double.search_type, param_double.search_param).and_return(true)
        expect(matcher_double).to receive(:new).with(param_double.search_type, param_double.search_param).and_return(test_return)
        expect(MatcherBuilder.build(param_double)).to eq(test_return)
      end
    end

    describe "does not find a matcher to build" do
      it "returns nil" do
        expect(matcher_double).to receive(:build_me?).and_return(false)
        expect(MatcherBuilder.build(param_double)).to be_nil
      end
    end
  end
end
