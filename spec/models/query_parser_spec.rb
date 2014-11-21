require_relative '../../app/models/query_parser'

RSpec.describe QueryParser do
  describe "parse" do
    it "creates an instance of query parser" do
      returned = QueryParser.parse("test=hello", Object.new)
      expect(returned).to be_a(QueryParser)
    end
  end

  describe "new" do
    describe "with a unparsed query" do
      let(:unparsed_query) { "test=hello" }

      it "sets its properties from the query components" do
        it = QueryParser.new("test=hello", Object.new)
        expect(it.search_type).to eq(:test)
        expect(it.search_param).to eq('hello')
      end
    end

    describe "without an unparsed query" do
      it "defaults to search all" do
        it = QueryParser.new(nil, Object.new)
        expect(it.search_type).to eq(:all)
        expect(it.search_param).to be_nil
      end
    end
  end

  describe "valid?" do
    let(:search_target) { double("CourseRepository") }

    describe "when given an invalid unparsed query" do
      it "is invalid" do
        ["writing_intensivetrue", "=true", "writing_intensive"].each do |invalid_query|
          it = QueryParser.new(invalid_query, search_target)
          expect(it.valid?).to be_falsey
        end
      end
    end

    describe "when given an search type the target doesn't understand" do
      it "is invalid" do
        it = QueryParser.new('bad_search=true', search_target)
        expect(it.valid?).to be_falsey
      end
    end

    describe "when given an nil search type and the target doesn't understand all" do
      it "is invalid" do
        search_target = Object.new

        it = QueryParser.new(nil, search_target)
        expect(it.valid?).to be_falsey
      end
    end

    describe "when given search type the target understands" do
      it "is valid" do
        allow(search_target).to receive(:writing_intensive)
        it = QueryParser.new('writing_intensive=true', search_target)

        expect(it.valid?).to be_truthy
      end
    end
  end
end
