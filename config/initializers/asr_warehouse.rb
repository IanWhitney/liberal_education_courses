module AsrWarehouse
  def self.schema_name
    ActiveRecord::Base.connection.instance_variable_get(:@config)[:schema] || "asr_warehouse"
  end
end
