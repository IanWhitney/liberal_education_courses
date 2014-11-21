require_relative '../../app/models/course_search'
require_relative '../../app/models/course_repository'

RSpec.describe CourseSearch do
  let(:course_repository) { double("CourseRepository") }
  let(:courses_double) { Object.new }
  let(:parsed_query) { instance_double("QueryParser") }

  before do
    allow(parsed_query).to receive(:valid?).and_return(true)
    allow(parsed_query).to receive(:search_type).and_return(''.to_sym)
    allow(parsed_query).to receive(:search_param)
  end

  describe "search class method" do
    describe "given no parameters" do
      it "returns CourseRepository.all" do
        allow(parsed_query).to receive(:search_type).and_return(:all)
        expect(course_repository).to receive(:all).and_return(courses_double)
        expect(QueryParser).to receive(:parse).with(nil, course_repository).and_return(parsed_query)
        results = CourseSearch.search(nil,course_repository)

        expect(results).to equal(courses_double)
      end
    end

    describe "given parameters" do
      describe "that are valid" do
        it "uses the parsed parameters to query CourseRepository" do
          allow(parsed_query).to receive(:search_type).and_return(:writing_intensive)
          allow(parsed_query).to receive(:search_param).and_return('true')
          expect(QueryParser).to receive(:parse).with('writing_intensive=true', course_repository).and_return(parsed_query)
          expect(course_repository).to receive(:writing_intensive).with('true')
          CourseSearch.search('writing_intensive=true', course_repository)
        end
      end

      describe "that are invalid" do
        it "returns nil" do
          allow(parsed_query).to receive(:valid?).and_return(false)

          expect(QueryParser).to receive(:parse).with('invalid=true', course_repository).and_return(parsed_query)
          expect(CourseSearch.search('invalid=true', course_repository)).to be_nil
        end
      end
    end
  end
end
