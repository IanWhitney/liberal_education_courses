class CoursesController < ApplicationController
  respond_to :json

  def index
    if params[:q]
      query = QueryParser.parse(params[:q])
      if CourseRepository.respond_to?(query.search_type)
        @courses = CourseRepository.public_send(query.search_type, query.search_param)
      else
        @courses = {}
      end
    else
      @courses = CourseRepository.all
    end

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
