require_relative "../search_parameter"

class MatchAttribute < SearchParameter
  def match?(target)
    !target.public_send(attribute).nil?
  end

  def self.build_me?(_, search_param)
    search_param == "true" || search_param == "all"
  end
end
