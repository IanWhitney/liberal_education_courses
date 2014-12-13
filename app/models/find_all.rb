require_relative "search_parameter"

class FindAll < SearchParameter
  def all?
    true
  end

  def match?(_)
    true
  end
end
