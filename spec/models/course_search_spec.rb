require_relative "../../app/models/course_search"
require_relative "../../app/models/search_parameters"
require_relative "../../app/models/liberal_education_course"

RSpec.describe CourseSearch do
  let(:search_target) { double("LiberalEducationCourse") }
  let(:search_params) { double("SearchParameters") }

  describe "search is for all" do
    it "returns the search_target.all results" do
      rand_result = rand
      allow(search_params).to receive(:all?).and_return(true)
      expect(search_target).to receive(:all).and_return(rand_result)
      expect(CourseSearch.search(search_params, search_target)).to eq(rand_result)
    end
  end

  describe "search is not for all" do
    it "returns the search_target.where results" do
      rand_result = rand
      allow(search_params).to receive(:all?).and_return(false)
      expect(search_target).to receive(:where).with(search_params).and_return(rand_result)
      expect(CourseSearch.search(search_params, search_target)).to eq(rand_result)
    end
  end
end
