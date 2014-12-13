require_relative "search_parameter"

class MatchAll < SearchParameter
  def all?
    true
  end

  def match?(_)
    true
  end
end
