class CourseSearch
  attr_reader :results

  def self.search(params = nil, search_target = LiberalEducationCourse)
    params = QueryParser.parse(params, search_target)
    if params.valid?
      new(params, search_target).results
    end
  end

  def initialize(params, search_target)
    self.results = search_target.where(params.search_type, params.search_param)
  end

  private

  attr_writer :results
end
