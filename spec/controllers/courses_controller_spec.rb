require "rails_helper"

RSpec.describe CoursesController do
  describe "GET index" do
    it "won't respond to a html request" do
      course_double = [rand]
      parameters_double = double("SearchParameters")

      expect(SearchParameters).to receive(:parse).with(nil).and_return(parameters_double)
      expect(LiberalEducationCourse).to receive(:where).with(parameters_double).and_return(course_double)

      get :index, format: :html
      expect(response).to have_http_status(400)
    end

    describe "without parameters" do
      it "runs a course search without params" do
        course_double = [rand]
        parameters_double = double("SearchParameters")

        expect(SearchParameters).to receive(:parse).with(nil).and_return(parameters_double)
        expect(LiberalEducationCourse).to receive(:where).with(parameters_double).and_return(course_double)

        get :index, format: :json
        expect(assigns(:courses)).to eq(course_double)
      end
    end

    describe "with parameters" do
      it "searches with the requested parameters" do
        course_double = [rand]
        parameters_double = double("SearchParameters")

        expect(SearchParameters).to receive(:parse).with("designated_theme=gp").and_return(parameters_double)
        expect(LiberalEducationCourse).to receive(:where).with(parameters_double).and_return(course_double)

        get :index, format: :json, q: "designated_theme=gp"
        expect(assigns(:courses)).to eq(course_double)
      end
    end
  end
end
