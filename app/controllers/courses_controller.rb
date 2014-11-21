class CoursesController < ApplicationController
  respond_to :json

  def index
    @courses = CourseSearch.new(params[:q])

    respond_with(@courses) do |format|
      format.json { render json: @courses }
      format.any  { render nothing: true, status: :bad_request }
    end
  end
end

class QueryParser
  attr_accessor :search_type, :search_param

  def self.parse(raw_query)
    self.new(raw_query)
  end

  def initialize(raw_query)
    self.search_type, self.search_param = raw_query.split("=")
  end
end
