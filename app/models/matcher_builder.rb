class MatcherBuilder
  attr_reader :search_param

  def self.build(raw_query = nil)
    x = new(raw_query)
    if x.match_all?
      MatchAll.new
    elsif x.match_attribute_exists?
      MatchAttribute.new(x.search_type)
    elsif x.match_atttribute_not_exist?
      MatchNoAttribute.new(x.search_type)
    elsif x.match_attribute_value?
      MatchAttributeValue.new(x.search_type, x.search_param)
    else
      SearchParameter.new(x.search_type, x.search_param)
    end
  end

  def initialize(raw_query)
    self.search_type, self.search_param = raw_query.to_s.split("=")
  end

  def search_type
    @search_type ? @search_type.to_sym : nil
  end

  def match_all?
    search_type.nil? && search_param.nil?
  end

  def match_attribute_exists?
    search_param == "true" || search_param == "all"
  end

  def match_atttribute_not_exist?
    search_param == "false" || search_param == "none"
  end

  def match_attribute_value?
    search_param && search_param && !match_attribute_exists? && !match_atttribute_not_exist?
  end

  private

  attr_writer :search_type, :search_param
end
