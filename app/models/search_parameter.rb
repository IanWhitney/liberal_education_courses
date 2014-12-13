SearchParameter = Struct.new(:attribute, :value) do
  def all?
    attribute == :all
  end

  def match?(target)
    target.public_send(attribute) == value
  end
end
