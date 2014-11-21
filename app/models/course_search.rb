class CourseSearch
  attr_reader :results

  def self.search(params=nil, course_repository=CourseRepository)
    params = QueryParser.parse(params)
    if params.valid?
      self.new(params,course_repository).results
    end
  end

  def initialize(params, course_repository)
    self.results = course_repository.public_send(params.search_type, params.search_param)
  end

  private
  attr_writer :results
end
