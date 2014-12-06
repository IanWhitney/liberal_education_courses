require_relative "../../app/models/search_parameters"
require_relative "../../app/models/query_parser"
require_relative "../../app/models/search_parameter"

RSpec.describe SearchParameters do
  describe "parse" do
    describe "with a single-element  and multi-element query_string" do
      let(:single_query_string) { "test=filter" }
      let(:multi_query_string) { "test=filter,test2=filter2" }
      let(:single_element) { SearchParameters.parse(single_query_string) }
      let(:multi_element) { SearchParameters.parse(multi_query_string) }

      describe "returns a collection" do
        it "that is enumerable" do
          [single_element, multi_element].each do |it|
            expect(it).to respond_to(:each)
          end
        end

        describe "whose contents" do
          it "have attributes that are symbols" do
            expect(single_element.collect(&:attribute)).to eq([:test])
            expect(multi_element.collect(&:attribute)).to eq([:test, :test2])
          end

          it "have values that are uppercased strings" do
            expect(single_element.collect(&:value)).to eq(["FILTER"])
            expect(multi_element.collect(&:value)).to eq(%w(FILTER FILTER2))
          end
        end
      end

      it "returns false to all?" do
        [single_element, multi_element].each do |it|
          expect(it.all?).to be_falsey
        end
      end
    end

    describe "without a query_string" do
      let(:no_element) { SearchParameters.parse(nil) }
      it "returns true to all?" do
        expect(no_element.all?).to be_truthy
      end
    end
  end
end