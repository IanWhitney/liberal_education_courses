json.courses @courses do |course|
  json.course_id           course.course_id
  json.subject             course.subject
  json.catalog_number      course.catalog_number
  json.title               course.title
  json.diversified_core    course.diversified_core
  json.designated_theme    course.designated_theme
  json.writing_intensive   course.writing_intensive
end
