class SearchParameters
  extend Forwardable

  def_delegators :@collection, :[], :any?, :each_with_object, :each, :collect

  def self.parse(params)
    new(params.to_s.split(","))
  end

  def initialize(params)
    if params.any?
      params.each do |p|
        search_params = QueryParser.parse(p)
        collection <<  MatchAttribute.new(search_params.keys.first, search_params.values.first)
      end
    else
      collection << FindAll.new
    end
  end

  def collection
    @collection ||= []
  end
end
