class ParameterSearch
  def self.search(data, search_parameters)
    result_sets = search_parameters.each_with_object([]) do |param, ret|
      ret << (data.select { |c| param.match?(c) }).to_set
    end
    result_sets.inject(:intersection).to_a
  end
end
