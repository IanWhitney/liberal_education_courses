class LiberalEducationCourse
  def self.all
    retrieve(nil)
  end

  def self.where(conditions)
    retrieve(conditions)
  rescue
    []
  end

  def self.retrieve(filter)
    if CachedCourseRepository.empty?
      CachedCourseRepository.add(DbCourseRepository.all)
    end

    if filter
      CachedCourseRepository.search(filter)
    else
      CachedCourseRepository.all
    end
  end
end
