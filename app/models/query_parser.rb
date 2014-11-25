class QueryParser
  attr_accessor :search_param

  def self.parse(raw_query, query_target)
    new(raw_query, query_target)
  end

  def initialize(raw_query, query_target)
    self.query_target = query_target

    if /\w+=\w/.match(raw_query)
      self.search_type, self.search_param = raw_query.split("=")
    elsif raw_query.nil?
      self.search_type = "all"
      self.search_param = nil
    end
  end

  def search_type
    @search_type ? @search_type.to_sym : nil
  end

  def valid?
    search_type && query_target.respond_to?(search_type)
  end

  private

  attr_accessor :query_target
  attr_writer :search_type
end
