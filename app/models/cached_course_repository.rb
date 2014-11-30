class CachedCourseRepository
  def self.empty?
    all.nil?
  end

  def self.add(courses)
    self.collection = courses.each_with_object([]) do |course, ret|
      ret << course
    end
  end

  def self.all
    collection
  end

  def self.query(search_parameters)
    search_parameters = Array(search_parameters)
    if search_parameters.any?
      search_results(search_parameters)
    else
      all
    end
  end

  def self.clear
    Rails.cache.clear
  end

  def self.collection
    Rails.cache.read("all_courses")
  end

  def self.collection=(x)
    Rails.cache.write("all_courses", x, expires_in: 24 * 60 * 60)
  end

  def self.search_results(search_parameters)
    result_sets = search_parameters.each_with_object([]) do |param, ret|
      ret << (collection.select { |c| c.public_send(param.attribute) == param.value }).to_set
    end
    result_sets.inject(:intersection).to_a
  end

  private_class_method :collection, :collection=, :search_results
end
