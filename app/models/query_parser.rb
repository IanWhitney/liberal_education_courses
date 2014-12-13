class QueryParser
  def self.parse(raw_query)
    x = new(raw_query)
    { x.search_type => x.search_param }
  end

  def initialize(raw_query)
    if /\w+=\w/.match(raw_query)
      self.search_type, self.search_param = raw_query.split("=")
    end
  end

  def search_type
    @search_type ? @search_type.to_sym : nil
  end

  def search_param
    if search_type == :writing_intensive
      "WI"
    else
      @search_param.to_s.upcase
    end
  end

  private

  attr_writer :search_type, :search_param
end
