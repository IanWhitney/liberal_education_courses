class LiberalEducationCourse < ActiveRecord::Base
  self.table_name = "#{AsrWarehouse.schema_name}.ps_crse_catalog"

  def self.all(_ = nil)
    filter = "dc.crse_attr_value is not null OR dt.crse_attr_value is not null OR wi.crse_attr_value is not null"
    retrieve(filter)
  end

  def self.writing_intensive(_ = nil)
    filter = "wi.crse_attr_value = 'WI'"
    retrieve(filter)
  end

  def self.designated_theme(theme)
    filter = "dt.crse_attr_value = '#{theme.upcase}'"
    retrieve(filter)
  end

  def self.diversified_core(core)
    filter = "dc.crse_attr_value = '#{core.upcase}'"
    retrieve(filter)
  end

  def self.retrieve(filter)
    if Rails.cache.read(filter)
      Rails.cache.read(filter)
    else
      Rails.cache.write(filter, retrieve_from_db(filter), expires_in: 24 * 60 * 60)
      retrieve(filter)
    end
  end

  # rubocop:disable MethodLength
  def self.retrieve_from_db(where_clause)
    sql = <<EOS
    with crse_catalog_eff_keys as (
      select crse_id, max(effdt) as effdt
      from #{AsrWarehouse.schema_name}.ps_crse_catalog
      where effdt <= sysdate
      group by crse_id
    ),
    eff_crse_catalog as (
      select ca.*
      from #{AsrWarehouse.schema_name}.ps_crse_catalog ca
        join crse_catalog_eff_keys eff_keys
          on ca.crse_id = eff_keys.crse_id
            and ca.effdt = eff_keys.effdt
    ),
    cle_courses as (
      select *
      from #{AsrWarehouse.schema_name}.ps_crse_attributes
      where crse_attr = 'CLE'
    ),
    diversified_core as (
      select *
      from cle_courses
      where crse_attr_value in ('AH','HIS','BIOL','LITR','MATH','PHYS','SOCS')
    ),
    designated_theme as (
      select *
      from cle_courses
      where crse_attr_value in ('GP','TS','CIV','DSJ','ENV')
    ),
    writing_intensive as (
      select *
      from cle_courses
      where crse_attr_value in ('WI')
    )
    select
      co.subject as subject,
      co.catalog_nbr as catalog_number,
      cc.crse_id as course_id,
      cc.course_title_long as title,
      dc.crse_attr_value as diversified_core,
      dt.crse_attr_value as designated_theme,
      wi.crse_attr_value as writing_intensive
    from eff_crse_catalog cc
      join #{AsrWarehouse.schema_name}.ps_crse_offer co
        on cc.crse_id = co.crse_id
          and cc.effdt = co.effdt
      left join diversified_core dc
        on cc.crse_id = dc.crse_id
          and cc.effdt = dc.effdt
      left join designated_theme dt
        on cc.crse_id = dt.crse_id
          and cc.effdt = dt.effdt
      left join writing_intensive wi
        on cc.crse_id = wi.crse_id
          and cc.effdt = wi.effdt
    where
    1 = 1
      and (dc.crse_attr_value is not null or dt.crse_attr_value is not null or wi.crse_attr_value is not null)
      and (#{where_clause})
    order by co.subject, co.catalog_nbr
EOS
    sanitized_sql = sanitize_sql(sql)
    find_by_sql(sanitized_sql)
  end

  private_class_method :retrieve, :retrieve_from_db
end
