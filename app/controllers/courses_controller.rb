class CoursesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :index

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "GET"
    headers["Access-Control-Max-Age"] = "1728000"
  end

  def cors_preflight_check
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "GET"
    headers["Access-Control-Max-Age"] = "1728000"
  end

  respond_to :json

  def index
    @courses = CourseSearch.search(params[:q])

    respond_with(@courses) do |format|
      format.json { render }
      format.any  { render nothing: true, status: :bad_request }
    end
  end
end
