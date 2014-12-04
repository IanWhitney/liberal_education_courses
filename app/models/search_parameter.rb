SearchParameter = Struct.new(:attribute, :value) do
  def all?
    attribute == :all
  end
end
