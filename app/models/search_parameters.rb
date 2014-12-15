class SearchParameters
  extend Forwardable

  def_delegators :@collection, :[], :any?, :each_with_object, :each, :collect

  def self.parse(params)
    new(QueryOptions.parse(params))
  end

  def initialize(params)
    if params.any?
      params.each do |p|
        collection << MatcherFactory.build(p, AbstractMatcher.matchers)
      end
    else
      collection << MatcherFactory.build(nil, AbstractMatcher.matchers)
    end
  end

  def collection
    @collection ||= []
  end
end
