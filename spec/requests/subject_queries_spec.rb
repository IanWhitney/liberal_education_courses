require "rails_helper"

RSpec.describe "Filtering by Subject" do
  describe "All courses in a subject" do
    it "returns json with liberal education courses taught in that subject" do
      get "/courses.json?q=subject=JOUR"
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["courses"].any?).to be_truthy

      parsed_response["courses"].each do |course|
        expect(course["subject"]).to eq("JOUR")
        wi = course["writing_intensive"]
        dt = course["designated_theme"]
        dc = course["diversified_core"]
        le_criteria = [wi, dt, dc].compact

        expect(le_criteria.any?).to be_truthy
      end
    end
  end
end
