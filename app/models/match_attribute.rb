require_relative "search_parameter"

class MatchAttribute < SearchParameter
  def match?(target)
    !target.public_send(attribute).nil?
  end
end
