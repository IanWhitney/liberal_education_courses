require_relative "../../app/models/course_search"
require_relative "../../app/models/liberal_education_course"

RSpec.describe CourseSearch do
  let(:search_target) { double("LiberalEducationCourse") }
  let(:courses_double) { Object.new }
  let(:parsed_query) { instance_double("QueryParser") }

  before do
    allow(parsed_query).to receive(:valid?).and_return(true)
    allow(parsed_query).to receive(:search_type).and_return("".to_sym)
    allow(parsed_query).to receive(:search_param)
  end

  describe "search class method" do
    describe "given no parameters" do
      it "returns LiberalEducationCourse.all" do
        allow(parsed_query).to receive(:search_type).and_return(:all)
        expect(search_target).to receive(:where).and_return(courses_double)
        expect(QueryParser).to receive(:parse).with(nil, search_target).and_return(parsed_query)
        results = CourseSearch.search(nil, search_target)

        expect(results).to equal(courses_double)
      end
    end

    describe "given parameters" do
      describe "that are valid" do
        it "uses the parsed parameters to query LiberalEducationCourse" do
          allow(parsed_query).to receive(:search_type).and_return(:writing_intensive)
          allow(parsed_query).to receive(:search_param).and_return("true")
          expect(QueryParser).to receive(:parse).with("writing_intensive=true", search_target).and_return(parsed_query)
          expect(search_target).to receive(:where).with(writing_intensive: "true")
          CourseSearch.search("writing_intensive=true", search_target)
        end
      end

      describe "that are invalid" do
        it "returns nil" do
          allow(parsed_query).to receive(:valid?).and_return(false)

          expect(QueryParser).to receive(:parse).with("invalid=true", search_target).and_return(parsed_query)
          expect(CourseSearch.search("invalid=true", search_target)).to be_nil
        end
      end
    end
  end
end
