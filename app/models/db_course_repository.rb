class DbCourseRepository < ActiveRecord::Base
  self.table_name = "#{AsrWarehouse.schema_name}.ps_crse_catalog"

  # rubocop:disable Metrics/MethodLength
  def self.all
    sql = <<EOS
    with crse_catalog_eff_keys as (
      select crse_id, max(effdt) as effdt
      from #{AsrWarehouse.schema_name}.ps_crse_catalog
      where effdt <= '2016-09-06'
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
      course_offer.subject as subject,
      course_offer.catalog_nbr as catalog_number,
      eff_courses.crse_id as course_id,
      eff_courses.course_title_long as title,
      diversified_core_courses.crse_attr_value as diversified_core,
      designated_theme_courses.crse_attr_value as designated_theme,
      writing_intensive_courses.crse_attr_value as writing_intensive
    from eff_crse_catalog eff_courses
      join #{AsrWarehouse.schema_name}.ps_crse_offer course_offer
        on eff_courses.crse_id = course_offer.crse_id
          and eff_courses.effdt = course_offer.effdt
      left join diversified_core diversified_core_courses
        on eff_courses.crse_id = diversified_core_courses.crse_id
          and eff_courses.effdt = diversified_core_courses.effdt
      left join designated_theme designated_theme_courses
        on eff_courses.crse_id = designated_theme_courses.crse_id
          and eff_courses.effdt = designated_theme_courses.effdt
      left join writing_intensive writing_intensive_courses
        on eff_courses.crse_id = writing_intensive_courses.crse_id
          and eff_courses.effdt = writing_intensive_courses.effdt
    where
    1 = 1
    and (
          diversified_core_courses.crse_attr_value is not null
          or designated_theme_courses.crse_attr_value is not null
          or writing_intensive_courses.crse_attr_value is not null
        )
    and course_offer.institution = 'UMNTC'
    and course_offer.campus = 'UMNTC'
    and eff_courses.eff_status = 'A'
    order by course_offer.subject, course_offer.catalog_nbr
EOS
    sanitized_sql = sanitize_sql(sql)
    find_by_sql(sanitized_sql)
  end
end
