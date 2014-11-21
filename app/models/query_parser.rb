class QueryParser
  attr_accessor :search_type, :search_param

  def self.parse(raw_query, query_target)
    self.new(raw_query)
  end

  def initialize(raw_query)
    if raw_query
      self.search_type, self.search_param = raw_query.split("=")
    else
      self.search_type = 'all'
      self.search_param = nil
    end
  end

  def valid?
    true
  end
end
