class LiberalEducationCourse
  def self.all
    if CachedCourseRepository.empty?
      CachedCourseRepository.add(DbCourseRepository.all)
    end
    CachedCourseRepository.all
  end
end
