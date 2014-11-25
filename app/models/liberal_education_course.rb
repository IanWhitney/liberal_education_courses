class LiberalEducationCourse < ActiveRecord::Base
  self.table_name = "#{AsrWarehouse.schema_name}.ps_crse_catalog"

  def self.all(_=nil)
    filter = "diversified_core_courses.crse_attr_value is not null OR designated_theme_courses.crse_attr_value is not null OR writing_intensive_courses.crse_attr_value is not null"
    retrieve(filter)
  end

  def self.writing_intensive(_)
    filter = "writing_intensive_courses.crse_attr_value = 'WI'"
    retrieve(filter)
  end

  def self.designated_theme(theme)
    filter = "designated_theme_courses.crse_attr_value = '#{theme.upcase}'"
    retrieve(filter)
  end

  def self.diversified_core(theme)
    filter = "diversified_core_courses.crse_attr_value = '#{theme.upcase}'"
    retrieve(filter)
  end

  private

  def self.retrieve(filter)
    if Rails.cache.read(filter)
      Rails.cache.read(filter)
    else
      Rails.cache.write(filter, self.retrieve_from_db(filter), :expires_in => 24 * 60 * 60)
      self.retrieve(filter)
    end
  end

  def self.retrieve_from_db(where_clause)
    sql = <<EOS
      select
        offer.subject subject,
        offer.catalog_nbr catalog_number,
        crse.crse_id course_id,
        crse.course_title_long title,
        diversified_core_courses.crse_attr_value diversified_core,
        designated_theme_courses.crse_attr_value designated_theme,
        writing_intensive_courses.crse_attr_value writing_intensive
      from
        #{AsrWarehouse.schema_name}.ps_crse_catalog crse
        left join #{AsrWarehouse.schema_name}.ps_crse_attributes diversified_core_courses
        on
          crse.crse_id = diversified_core_courses.crse_id
          and diversified_core_courses.crse_attr in ('CLE')
          and diversified_core_courses.crse_attr_value in ('AH','HIS','BIOL','LITR','MATH','PHYS','SOCS')
        left join #{AsrWarehouse.schema_name}.ps_crse_attributes designated_theme_courses
        on
          crse.crse_id = designated_theme_courses.crse_id
          and designated_theme_courses.crse_attr in ('CLE')
          and designated_theme_courses.crse_attr_value in ('GP','TS','CIV','DSJ','ENV')
        left join #{AsrWarehouse.schema_name}.ps_crse_attributes writing_intensive_courses
        on
          crse.crse_id = writing_intensive_courses.crse_id
          and writing_intensive_courses.crse_attr in ('CLE')
          and writing_intensive_courses.crse_attr_value in ('WI')
        inner join #{AsrWarehouse.schema_name}.ps_crse_offer offer
        on
          crse.crse_id = offer.crse_id
          and crse.effdt = offer.effdt
      where
        1 = 1
        AND crse.effdt=(
          select max(effdt)
          from #{AsrWarehouse.schema_name}.ps_crse_catalog
          where crse_id=crse.crse_id
          and effdt <= sysdate
          and eff_status = 'A'
        )
        and
        (
          #{where_clause}
        )
      group by
        offer.subject,
        offer.catalog_nbr,
        crse.crse_id,
        crse.course_title_long,
        diversified_core_courses.crse_attr_value,
        designated_theme_courses.crse_attr_value,
        writing_intensive_courses.crse_attr_value
      order by
        offer.subject,
        offer.catalog_nbr
EOS

    self.find_by_sql(sql)
  end
end
