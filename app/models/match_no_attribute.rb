require_relative "search_parameter"

class MatchNoAttribute < SearchParameter
  def match?(target)
    target.public_send(attribute).nil?
  end

  def self.build_me?(_, search_param)
    search_param == "false" || search_param == "none"
  end
end
