class CourseSearch
  def self.search(search_params, search_target = LiberalEducationCourse)
    search_target.where(search_params)
  end
end
