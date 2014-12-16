require "rails_helper"

RSpec.describe CoursesController do
  describe "GET index" do
    it "won't respond to a html request" do

      allow(ApiServiceSearching).to receive(:where)
      allow(LiberalEducationCourse).to receive(:all)

      get :index, format: :html
      expect(response).to have_http_status(400)
    end

    describe "without parameters" do
      it "runs a course search without params" do
        course_double = [rand]

        allow(LiberalEducationCourse).to receive(:all).and_return(course_double)
        allow(ApiServiceSearching).to receive(:where).with(course_double, nil).and_return(course_double)

        get :index, format: :json
        expect(assigns(:courses)).to eq(course_double)
      end
    end

    describe "with parameters" do
      it "runs a course search with params" do
        course_double = [rand]

        allow(LiberalEducationCourse).to receive(:all).and_return(course_double)
        allow(ApiServiceSearching).to receive(:where).with(course_double, "designated_theme=gp").and_return(course_double)

        get :index, format: :json, q: "designated_theme=gp"
        expect(assigns(:courses)).to eq(course_double)
      end
    end
  end
end
