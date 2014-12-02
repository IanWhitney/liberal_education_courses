require_relative "../../app/models/liberal_education_course"
require_relative "../../app/models/search_parameter"
require_relative "../../app/models/cached_course_repository"

RSpec.describe LiberalEducationCourse do
  before do
    allow(CachedCourseRepository).to receive(:empty?).and_return(false)
  end

  describe "where" do
    describe "single filters" do
      it "search the repo with just one filter" do
        [:writing_intensive, :designated_theme, :diversified_core, :subject].each do |filter|
          search_param_double = double("SearchParameter")
          rand_result = rand
          expect(SearchParameter).to receive(:new).with(filter, "WI").and_return(search_param_double)
          expect(CachedCourseRepository).to receive(:query).with([search_param_double]).and_return(rand_result)
          expect(LiberalEducationCourse.where(filter => "WI")).to eq(rand_result)
        end
      end
    end

    describe "multiple filters" do
      it "searches the repo with all filters" do
        search_param_double = double("SearchParameter")
        rand_result = rand
        search_filters = { writing_intensive: "#{rand}", diversified_core: "#{rand}" }

        expect(SearchParameter).to receive(:new).twice.and_return(search_param_double)

        expect(CachedCourseRepository).to receive(:query).with([search_param_double, search_param_double]).and_return(rand_result)

        expect(LiberalEducationCourse.where(search_filters)).to eq(rand_result)
      end
    end

    describe "invalid searches" do
      it "returns an empty set" do
        expect(LiberalEducationCourse.where(diversified_core: "basketweaving")).to eq([])
        expect(LiberalEducationCourse.where(easy_a: nil)).to eq([])
      end
    end
  end
end
