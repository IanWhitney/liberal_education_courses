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
        filter = { diversified_core: course.diversified_core }
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
  end

  describe "add" do
    it "puts courses into the repository" do
      courses_to_add = generate_courses(rand(5))
      CachedCourseRepository.add(courses_to_add)
      expect(CachedCourseRepository.all).to eq(courses_to_add)
    end
  end
end

def generate_courses(count)
  (1..count).each_with_object([]) do |_, ret|
    ret << Course.new(rand, rand, rand, rand, rand, rand, rand)
  end
end

