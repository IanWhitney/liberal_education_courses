class CourseSearch
  def self.search(params = nil, search_target = LiberalEducationCourse)
    search_params = QueryParser.parse(params)
    search_target.where(search_params)
  end
end
