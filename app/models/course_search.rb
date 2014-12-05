class CourseSearch
  def self.search(search_params = nil, search_target = LiberalEducationCourse)
    if search_params.all?
      search_target.all
    else
      search_target.where(search_params)
    end
  end
end
