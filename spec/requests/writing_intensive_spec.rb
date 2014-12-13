require "rails_helper"

RSpec.describe "Client requests courses:" do
  describe "With writing intensive" do
    it "returns json with courses collection" do
      get "courses.json?q=writing_intensive=true"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.keys).to include("courses")
      random_course = parsed_response["courses"].sample
      required_keys = %w(course_id subject catalog_number title diversified_core designated_theme writing_intensive)

      required_keys.each do |required_key|
        expect(random_course.keys).to include(required_key)
      end

      parsed_response["courses"].each do |course|
        expect(course["writing_intensive"]).to eq("WI")
      end
    end
  end

  describe "Without writing intensive" do
    it "returns json with courses collection" do
      get "courses.json?q=writing_intensive=false"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.keys).to include("courses")
      random_course = parsed_response["courses"].sample
      required_keys = %w(course_id subject catalog_number title diversified_core designated_theme writing_intensive)

      required_keys.each do |required_key|
        expect(random_course.keys).to include(required_key)
      end

      parsed_response["courses"].each do |course|
        expect(course["writing_intensive"]).to be_nil
      end
    end
  end
end
