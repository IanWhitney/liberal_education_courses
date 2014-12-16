require "rails_helper"
require_relative "../../app/models/cached_course_repository"

RSpec.describe CachedCourseRepository do
  before do
    CachedCourseRepository.clear
  end

  after do
    CachedCourseRepository.clear
  end

  describe "empty?" do
    it "is true if no courses have been added" do
      expect(CachedCourseRepository.empty?).to be_truthy
    end

    it "is false courses have been added" do
      CachedCourseRepository.add(generate_courses(1))
      expect(CachedCourseRepository.empty?).to be_falsey
    end
  end

  describe "add" do
    it "puts courses into the repository" do
      courses_to_add = generate_courses(rand(5))
      CachedCourseRepository.add(courses_to_add)
      expect(CachedCourseRepository.all).to eq(courses_to_add)
    end
  end

  describe "all" do
    it "returns all added courses" do
      courses_to_add = generate_courses(rand(5))
      CachedCourseRepository.add(courses_to_add)
      expect(CachedCourseRepository.all).to eq(courses_to_add)
    end
  end

  describe "search" do
    it "returns the courses that match all provided search_parameters" do
      course_one =   Course.new("matching_subject", rand, rand, rand, "WI", rand, rand)
      course_two =   Course.new("matching_subject", rand, rand, rand, "WI", rand, rand)
      course_three = Course.new("non_matching_subject", rand, rand, rand, "WI", rand, rand)
      CachedCourseRepository.add([course_one, course_two, course_three])

      filter_one = MatchAttributeValue.new(:subject, "matching_subject")
      filter_two = MatchAttributeValue.new(:diversified_core, "WI")
      results = CachedCourseRepository.search([filter_one, filter_two])

      expect(results).to include(course_one)
      expect(results).to include(course_two)
      expect(results).not_to include(course_three)
    end
  end
end

Course = Struct.new(:subject, :course_id, :catalog_number, :title, :diversified_core, :designated_theme, :writing_intensive)

def generate_courses(count)
  (0..count).each_with_object([]) do |_, ret|
    ret << Course.new(rand, rand, rand, rand, rand, rand, rand)
  end
end
