require_relative "../../app/models/liberal_education_course"
require_relative "../../app/models/matchers/match_attribute_value"
require_relative "../../app/models/cached_course_repository"

RSpec.describe LiberalEducationCourse do
  before do
    allow(CachedCourseRepository).to receive(:empty?).and_return(false)
  end

  describe "all" do
    it "returns the CachedCourseRepository.all results" do
      rand_result = rand
      expect(CachedCourseRepository).to receive(:all).and_return(rand_result)
      expect(LiberalEducationCourse.all).to eq(rand_result)
    end
  end

  describe "where" do
    describe "single filters" do
      it "search the repo with just one filter" do
        [:writing_intensive, :designated_theme, :diversified_core, :subject].each do |filter|
          rand_result = rand
          param = MatchAttributeValue.new(filter, "WI")
          expect(CachedCourseRepository).to receive(:search).with([param]).and_return(rand_result)
          expect(LiberalEducationCourse.where([param])).to eq(rand_result)
        end
      end
    end

    describe "multiple filters" do
      it "searches the repo with all filters" do
        rand_result = rand

        wi_param = MatchAttributeValue.new(:writing_intensive, "WI")
        dc_param = MatchAttributeValue.new(:diversified_core, "WI")

        expect(CachedCourseRepository).to receive(:search).with([wi_param, dc_param]).and_return(rand_result)

        expect(LiberalEducationCourse.where([wi_param, dc_param])).to eq(rand_result)
      end
    end

    describe "invalid searches" do
      it "returns an empty set" do
        invalid_param = MatchAttributeValue.new(:diversified_core, "basketweaving")
        expect(LiberalEducationCourse.where([invalid_param])).to eq([])
        invalid_param = MatchAttributeValue.new(:easy_a, nil)
        expect(LiberalEducationCourse.where([invalid_param])).to eq([])
      end
    end
  end
end
