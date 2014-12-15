class MatcherFactory
  attr_reader :search_param

  def self.build(query_option, build_options)
    constructor = build_options.detect { |m| m.build_me?(query_option.search_type, query_option.search_param) }

    if constructor
      constructor.new(query_option.search_type, query_option.search_param)
    end
  end

  private

  attr_writer :search_type, :search_param
end
