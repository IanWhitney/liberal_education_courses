class AbstractMatcher
  attr_accessor :attribute, :value

  def self.matchers
    # Be careful with the order of this array. git blame for more info.
    [MatchAll, MatchAttribute, MatchNoAttribute, MatchAttributeValue, self]
  end

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

  def self.build_me?(_, _)
    true
  end
end
