class SearchParameter
  attr_accessor :attribute, :value

  def initialize(attribute = nil, value = nil)
    self.attribute = attribute
    self.value = value
  end

  def all?
    false
  end

  def match?(_)
    false
  end
end

class FindAll < SearchParameter
  def all?
    true
  end

  def match?(_)
    true
  end
end

class MatchAttribute < SearchParameter
  def match?(target)
    target.public_send(attribute) == value
  end
end
