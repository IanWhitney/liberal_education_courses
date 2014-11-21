require 'rails_helper'

RSpec.describe CoursesController do
  describe "GET index" do
    it "won't respond to a html request" do
      get :index, format: :html
      expect(response).to have_http_status(400)
    end

    describe "without parameters" do
      it "runs a course search without params" do
        course_double = [rand]
        expect(CourseSearch).to receive(:search).with(nil).and_return(course_double)

        get :index, format: :json
        expect(assigns(:courses)).to eq(course_double)
      end
    end

    describe "with parameters" do
      it "searches with the requested parameters" do
        course_double = [rand]
        parameter_options = ['writing_intensive=true', 'designated_theme=gp', 'diversified_core=litr']
        parameter_options.each do |query_string|
          expect(CourseSearch).to receive(:search).with(query_string).and_return(course_double)

          get :index, format: :json, q: query_string
          expect(assigns(:courses)).to eq(course_double)
        end
      end
    end
  end
end
