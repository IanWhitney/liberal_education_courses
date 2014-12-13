class SearchParameter
  attr_accessor :attribute, :value

  def initialize(attribute, value)
    self.attribute = attribute
    self.value = value
  end

  def all?
    attribute == :all
  end

  def match?(target)
    target.public_send(attribute) == value
  end
end
