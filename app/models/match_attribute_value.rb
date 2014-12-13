class MatchAttributeValue < SearchParameter
  def match?(target)
    target.public_send(attribute).to_s.upcase == value.to_s.upcase
  end
end
