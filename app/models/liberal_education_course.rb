class LiberalEducationCourse
  def self.where(conditions)
    filters = conditions.each_with_object([]) do |condition, ret|
      ret << send(condition[0], condition[1])
    end
    retrieve(filters)
  rescue
    []
  end

  def self.retrieve(filter)
    if CachedCourseRepository.empty?
      CachedCourseRepository.add(DbCourseRepository.all)
    end
    CachedCourseRepository.query(filter)
  end

  def self.all(_ = nil)
    nil
  end

  def self.writing_intensive(_ = nil)
    SearchParameter.new(:writing_intensive, "WI")
  end

  def self.designated_theme(theme)
    SearchParameter.new(:designated_theme, theme.upcase)
  end

  def self.diversified_core(core)
    SearchParameter.new(:diversified_core, core.upcase)
  end

  def self.subject(subject)
    SearchParameter.new(:subject, subject.upcase)
  end

  private_class_method :writing_intensive, :designated_theme, :diversified_core, :subject, :all, :retrieve
end
