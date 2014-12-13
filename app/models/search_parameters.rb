class SearchParameters
  extend Forwardable

  def_delegators :@collection, :[], :any?, :each_with_object, :each, :collect

  def self.parse(params)
    new(params.to_s.split(","))
  end

  def initialize(params)
    if params.any?
      params.each do |p|
        collection << MatcherBuilder.build(p)
      end
    else
      collection << MatchAll.new
    end
  end

  def collection
    @collection ||= []
  end
end
