require_relative "../../app/models/search_parameters"
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
            expect(single_element.collect(&:value)).to eq(["filter"])
            expect(multi_element.collect(&:value)).to eq(%w(filter filter2))
          end
        end
      end
    end
  end
end
