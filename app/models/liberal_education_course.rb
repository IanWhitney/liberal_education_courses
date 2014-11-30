class LiberalEducationCourse
  def self.all(_ = nil)
    retrieve(nil)
  end

  def self.writing_intensive(_ = nil)
    filter = SearchParameter.new(:writing_intensive, "WI")
    retrieve(filter)
  end

  def self.designated_theme(theme)
    filter = SearchParameter.new(:designated_theme, theme.upcase)
    retrieve(filter)
  end

  def self.diversified_core(core)
    filter = SearchParameter.new(:diversified_core, core.upcase)
    retrieve(filter)
  end

  def self.subject(subject)
    filter = SearchParameter.new(:subject, subject.upcase)
    retrieve(filter)
  end

  def self.retrieve(filter)
    if CachedCourseRepository.empty?
      CachedCourseRepository.add(DbCourseRepository.all)
    end
    CachedCourseRepository.query(filter)
  end
end
