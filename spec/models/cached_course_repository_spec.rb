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

  describe "all" do
    it "returns all added courses" do
      courses_to_add = generate_courses(rand(5))
      CachedCourseRepository.add(courses_to_add)
      expect(CachedCourseRepository.all).to eq(courses_to_add)
    end
  end

  describe "query" do
    before do
      @courses_to_add = generate_courses(rand(5))
      CachedCourseRepository.add(@courses_to_add)
    end

    describe "with a provided filter" do
      it "returns the courses that match the filter options" do
        course = @courses_to_add.sample
        filter = SearchParameter.new(:diversified_core, course.diversified_core)
        results = CachedCourseRepository.query(filter)
        matched = @courses_to_add.select { |c| c.diversified_core == course.diversified_core }
        expect(results).to eq(matched)
      end
    end

    describe "without a provided filter" do
      it "returns all" do
        results = CachedCourseRepository.query(nil)
        expect(results).to eq(CachedCourseRepository.all)
      end
    end

    describe "with multiple filters" do
      it "returns the courses that match all filters" do
        course_one =   Course.new("matching_subject", rand, rand, rand, "WI", rand, rand)
        course_two =   Course.new("matching_subject", rand, rand, rand, "WI", rand, rand)
        course_three = Course.new("non_matching_subject", rand, rand, rand, "WI", rand, rand)
        CachedCourseRepository.add([course_one, course_two, course_three])
        filter_one = SearchParameter.new(:subject, "matching_subject")
        filter_two = SearchParameter.new(:diversified_core, "WI")
        results = CachedCourseRepository.query([filter_one, filter_two])
        expect(results).to include(course_one)
        expect(results).to include(course_two)
        expect(results).not_to include(course_three)
      end
    end
  end

  describe "add" do
    it "puts courses into the repository" do
      courses_to_add = generate_courses(rand(5))
      CachedCourseRepository.add(courses_to_add)
      expect(CachedCourseRepository.all).to eq(courses_to_add)
    end
  end
end

Course = Struct.new(:subject, :course_id, :catalog_number, :title, :diversified_core, :designated_theme, :writing_intensive)

def generate_courses(count)
  (0..count).each_with_object([]) do |_, ret|
    ret << Course.new(rand, rand, rand, rand, rand, rand, rand)
  end
end
