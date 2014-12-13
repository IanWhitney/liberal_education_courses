class MatcherBuilder
  attr_reader :search_param

  def self.build(raw_query = nil)
    parsed = new(raw_query)
    constructor = SearchParameter.matchers.detect { |m| m.build_me?(parsed.search_type, parsed.search_param) }

    if constructor
      constructor.new(parsed.search_type, parsed.search_param)
    end
  end

  def initialize(raw_query)
    self.search_type, self.search_param = raw_query.to_s.split("=")
  end

  def search_type
    @search_type ? @search_type.to_sym : nil
  end

  private

  attr_writer :search_type, :search_param
end
