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


