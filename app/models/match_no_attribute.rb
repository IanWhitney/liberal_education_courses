require_relative "search_parameter"

class MatchNoAttribute < SearchParameter
  def match?(target)
    target.public_send(attribute).nil?
  end
end
