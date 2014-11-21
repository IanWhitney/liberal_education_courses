class CoursesController < ApplicationController
  respond_to :json

  def index
    @courses = CourseSearch.search(params[:q])

    respond_with(@courses) do |format|
      format.json { render }
      format.any  { render nothing: true, status: :bad_request }
    end
  end
end

