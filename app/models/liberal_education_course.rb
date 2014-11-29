class LiberalEducationCourse
  def self.all(_ = nil)
    retrieve(nil)
  end

  def self.writing_intensive(_ = nil)
    filter = { writing_intensive: "WI" }
    retrieve(filter)
  end

  def self.designated_theme(theme)
    filter = { designated_theme: theme.upcase }
    retrieve(filter)
  end

  def self.diversified_core(core)
    filter = { diversified_core: core.upcase }
    retrieve(filter)
  end

  def self.retrieve(filter)
    if CachedCourseRepository.empty?
      CachedCourseRepository.add(DbCourseRepository.all)
    end
    CachedCourseRepository.query(filter)
  end
end
