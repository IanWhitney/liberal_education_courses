require_relative "../../app/models/query_parser"

RSpec.describe QueryParser do
  describe "parse" do
    it "creates an instance of query parser" do
      returned = QueryParser.parse("test=hello")
      expect(returned).to eq(test: "HELLO")
    end
  end

  describe "new" do
    describe "with a unparsed query" do
      let(:unparsed_query) { "test=hello" }

      it "sets its properties from the query components" do
        it = QueryParser.new("test=hello")
        expect(it.search_type).to eq(:test)
        expect(it.search_param).to eq("HELLO")
      end
    end

    describe "without an unparsed query" do
      it "defaults to search all" do
        it = QueryParser.new(nil)
        expect(it.search_type).to eq(:all)
        expect(it.search_param).to be_empty
      end
    end
  end
end
