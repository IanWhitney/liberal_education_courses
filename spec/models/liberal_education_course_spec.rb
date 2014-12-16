require_relative "../../app/models/liberal_education_course"
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
end
