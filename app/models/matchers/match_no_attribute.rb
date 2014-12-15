require_relative "../abstract_matcher"

class MatchNoAttribute < AbstractMatcher
  def match?(target)
    target.public_send(attribute).nil?
  end

  def self.build_me?(_, search_param)
    search_param == "false" || search_param == "none"
  end
end
