require "rails_helper"

RSpec.describe "Client requests courses:" do
  describe "All courses" do
    it "returns json with courses collection" do
      get "courses.json"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.keys).to include("courses")
      random_course = parsed_response["courses"].sample
      required_keys = %w(course_id subject catalog_number title diversified_core designated_theme writing_intensive)
      required_keys.each do |required_key|
        expect(random_course.keys).to include(required_key)
      end
    end
  end

  describe "Writing Intensive" do
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

  describe "Designated Theme" do
    it "returns json with courses collection" do
      # mixed case options because the readme says we support that
      themes = %w(gp TS Civ dSj enV)

      themes.each do |theme|
        get "courses.json?q=designated_theme=#{theme}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys).to include("courses")
        random_course = parsed_response["courses"].sample
        required_keys = %w(course_id subject catalog_number title diversified_core designated_theme writing_intensive)
        required_keys.each do |required_key|
          expect(random_course.keys).to include(required_key)
        end

        parsed_response["courses"].each do |course|
          expect(course["designated_theme"]).to eq(theme.upcase)
        end
      end
    end
  end

  describe "Diversified Core", :focus do
    it "returns json with courses collection" do
      # mixed case options because the readme says we support that
      cores = %w(ah Biol HIS lItr maTH phyS socs)

      cores.each do |core|
        get "courses.json?q=diversified_core=#{core}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys).to include("courses")
        random_course = parsed_response["courses"].sample
        required_keys = %w(course_id subject catalog_number title diversified_core designated_theme writing_intensive)
        required_keys.each do |required_key|
          expect(random_course.keys).to include(required_key)
        end

        parsed_response["courses"].each do |course|
          expect(course["diversified_core"]).to eq(core.upcase)
        end
      end
    end
  end

  describe "Invalid Queries" do
    describe "correct liberal education type, invalid option" do
      it "returns an empty courses collection" do
        get "courses.json?q=diversified_core=basketweaving"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["courses"]).to be_empty
      end
    end

    describe "incorrect liberal education type" do
      it "returns an empty json object" do
        get "courses.json?q=easy_a"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["courses"]).to be_empty
      end
    end
  end
end
