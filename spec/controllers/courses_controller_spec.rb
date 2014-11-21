require 'rails_helper'

RSpec.describe CoursesController do
  describe "GET index" do
    it "won't respond to a html request" do
      get :index, format: :html
      expect(response).to have_http_status(400)
    end

    describe "without parameters" do
      it "gets all courses from the repository" do
        course_double = [rand]
        expect(CourseRepository).to receive(:all).and_return(course_double)

        get :index, format: :json
        expect(assigns(:courses)).to eq(course_double)
      end
    end

    describe "with parameters" do
      describe "writing_intensive" do
        it "queries the repository for courses with writing_intensive of true" do
          course_double = [rand]
          expect(CourseRepository).to receive(:writing_intensive).and_return(course_double)

          get :index, format: :json, q: 'writing_intensive=true'
          expect(assigns(:courses)).to eq(course_double)
        end

        it "doesn't matter what the value of the query string is" do
          course_double = [rand]
          expect(CourseRepository).to receive(:writing_intensive).and_return(course_double)

          get :index, format: :json, q: 'writing_intensive=false'
          expect(assigns(:courses)).to eq(course_double)
        end
      end

      describe "designated_themes" do
        it "queries the repository for courses with the requested designated_theme" do
          course_double = [rand]
          theme = %w(gp ts civ dsj env).sample
          expect(CourseRepository).to receive(:designated_theme).with(theme).and_return(course_double)

          get :index, format: :json, q: "designated_theme=#{theme}"
          expect(assigns(:courses)).to eq(course_double)
        end
      end

      describe "diversified_core" do
        it "queries the repository for courses with the requested diversified_core" do
          course_double = [rand]
          core = %w(ah biol his litr math phys socs).sample
          expect(CourseRepository).to receive(:diversified_core).with(core).and_return(course_double)

          get :index, format: :json, q: "diversified_core=#{core}"
          expect(assigns(:courses)).to eq(course_double)
        end
      end

      describe "that are unsupported" do
        it "returns an empty hash" do
          get :index, format: :json, q: "invalid=#{rand}"
          expect(assigns(:courses)).to eq({})
        end
      end
    end
  end
end
