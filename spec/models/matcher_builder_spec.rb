require_relative "../../app/models/matcher_builder"
require_relative "../../app/models/match_attribute"
require_relative "../../app/models/match_no_attribute"
require_relative "../../app/models/match_attribute_value"

RSpec.describe MatcherBuilder do
  describe "build" do
    describe "no parameters provided" do
      it "returns a MatchAll" do
        match_double = Object.new
        expect(MatchAll).to receive(:new).and_return(match_double)
        it = MatcherBuilder.build
        expect(it).to eq(match_double)
      end
    end

    describe "boolean parameter provided" do
      describe "parameter is true" do
        it "returns a MatchAttribute" do
          match_double = Object.new
          expect(MatchAttribute).to receive(:new).with(:something).and_return(match_double)
          it = MatcherBuilder.build("something=true")
          expect(it).to eq(match_double)
        end
      end

      describe "parameter is false" do
        it "returns a MatchNoAttribute" do
          match_double = Object.new
          expect(MatchNoAttribute).to receive(:new).with(:something).and_return(match_double)
          it = MatcherBuilder.build("something=false")
          expect(it).to eq(match_double)
        end
      end
    end

    describe "string parameter provided" do
      it "returns a MatchAttributeValue" do
        match_double = Object.new
        expect(MatchAttributeValue).to receive(:new).with(:something, "value").and_return(match_double)
        it = MatcherBuilder.build("something=value")
        expect(it).to eq(match_double)
      end
    end
  end
end
