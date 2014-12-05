class SearchParameters
  extend Forwardable

  def_delegators :@collection, :[], :any?, :each_with_object, :each, :collect

  def self.parse(params)
    new(params.to_s.split(","))
  end

  def all?
    collection.any?(&:all?)
  end

  def initialize(params)
    if params.any?
      params.each do |p|
        search_params = QueryParser.parse(p)
        collection <<  SearchParameter.new(search_params.keys.first, search_params.values.first)
      end
    else
      collection << SearchParameter.new(:all, nil)
    end
  end

  def collection
    @collection ||= []
  end
end
