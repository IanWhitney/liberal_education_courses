class SearchParameter
  attr_accessor :attribute, :value

  def initialize(attribute, value)
    self.attribute = attribute
    self.value = value
  end

  private

  attr_writer :attribute, :value
end
