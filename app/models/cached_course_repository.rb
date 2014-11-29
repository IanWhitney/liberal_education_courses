Course = Struct.new(:subject, :course_id, :catalog_number, :title, :diversified_core, :designated_theme, :writing_intensive)

class CachedCourseRepository
  def self.empty?
    all.nil?
  end

  def self.add(courses)
    x = courses.each_with_object([]) do |course, ret|
      ret << Course.new(course.subject,
                        course.course_id,
                        course.catalog_number,
                        course.title,
                        course.diversified_core,
                        course.designated_theme,
                        course.writing_intensive)
    end
    self.collection = x
  end

  def self.all
    collection
  end

  def self.query(filter)
    if filter
      collection.select { |c| c.public_send(filter.keys.first) == filter.values.first }
    else
      all
    end
  end

  def self.collection
    Rails.cache.read("all_courses")
  end

  def self.collection=(x)
    Rails.cache.write("all_courses", x, expires_in: 24 * 60 * 60)
  end
end
