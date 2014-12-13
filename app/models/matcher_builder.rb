class MatcherBuilder
  attr_reader :search_param

  def self.build(raw_query = nil)
    if raw_query
      x = new(raw_query)
      if x.search_param == "true" || x.search_param == "all"
        MatchAttribute.new(x.search_type)
      elsif x.search_param == "false" || x.search_param == "none"
        MatchNoAttribute.new(x.search_type)
      else
        MatchAttributeValue.new(x.search_type, x.search_param)
      end
    else
      MatchAll.new
    end
  end

  def initialize(raw_query)
    self.search_type, self.search_param = raw_query.split("=")
  end

  def search_type
    @search_type ? @search_type.to_sym : nil
  end

  private

  attr_writer :search_type, :search_param
end
