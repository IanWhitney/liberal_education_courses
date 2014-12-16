# Liberal Education Courses

Public endpoint for getting data about UMNTC courses that satisfy one or more liberal education requirements

## Querying on Liberal Education criteria

### Get all courses

https://apps.asr.umn.edu/liberal_education_courses/courses.json

### Get all courses with writing_intensive, designated_theme or diversified_core

- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=writing_intensive=all
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=designated_theme=all
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=diversified_core=all

`all` and `true` are synonymous. So these could be written as:

- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=writing_intensive=true
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=designated_theme=true
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=diversified_core=true

### Get all courses without writing_intensive, designated_theme or diversified_core

- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=writing_intensive=none
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=designated_theme=none
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=diversified_core=none

`none` and `false` are synonymous. So these could be written as:

- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=writing_intensive=false
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=designated_theme=false
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=diversified_core=false

### Get all courses that satisfy a specific designated theme or diversified_core

- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=designated_theme=dsj
- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=diversified_core=ah

## Querying on Subject

### Get all Liberal Education courses taught in JOUR

https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=subject=JOUR

## Querying on Other Attributes

You can search based on any attribute returned in the JSON except for title. All of the below will work, but they won't return many courses.

- https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=course_id=807690
- https://apps.asr.umn.edu/courses.json?q=subject=math,catalog_number=4067W

## Querying on More Than One Attribute

Separate attributes with a comma. Courses that match all providided attributes will be returned.

https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=writing_intensive=true%2Csubject=JOUR

Will return courses that are writing intensive and that have the subject of JOUR

https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=writing_intensive=true%2Cdiversified_core=ah

Will return courses that are writing intensive and that have the American History diversified_core

https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=designated_theme=all%2Cdiversified_core=ah

Will return courses that meet any designated_theme and that have the American History diversified_core

## Return Values

Only returns JSON. Limited course data

```json
{
  "courses": [{
    "course_id": "807690",
    "subject": "MATH",
    "catalog_number": "4067W",
    "title": "Actuarial Mathematics in Practice",
    "diversified_core": null,
    "designated_theme": null,
    "writing_intensive": "WI"
  }
```

```json
{
  "courses": [{
    "course_id": "808233",
    "subject": "JOUR",
    "catalog_number": "3775",
    "title": "Administrative Law and Regulation for Strategic Communication",
    "diversified_core": null,
    "designated_theme": "CIV",
    "writing_intensive": "WI"
  }]
}

```

An empty courses collection will be returned if no courses match your criteria

```
https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=diversified_core=basketweaving
#=> {"courses": []}

https://apps.asr.umn.edu/liberal_education_courses/courses.json?q=easy_a
#=> {"courses": []}
```

## Limits

- If a course is cross-listed under multiple subject/catalog numbers, then it will appear in the results multiple times.
- Data comes from the Data Warehouse, so it is a day old.
- UMNTC only

## Reference

You can pass these in all caps, all lower-case, mixed caps, etc. But they will be all caps in the returned json

### IDs for Diversified Cores


- Ah: Arts & Humanities
- Biol: Biological Sciences
- His: Historical Perspectives
- Litr: Literature
- Math: Mathematical Thinking
- Phys: Physical Sciences
- Socs: Social Sciences

### IDs for Designated Theme

- Gp: Global Perspectives
- Ts: Technology and Society
- Civ: Civic Life and Ethics
- Dsj: Diversity and Social Justice in the U.S.
- Env: The Environment

## Development

### Getting Started

- Clone repo
- `bundle install --path ./vendor/bundle`
- Copy the database.yml file from app_configurations `rails/liberal_education_service/config` into `./config`
- `bundle exec rails s`

### Console Interaction

You can work at higher level:

```ruby
CourseSearch.search(
  SearchParameters.parse('writing_intensive=true')
)
```

Or,

```ruby
p = SearchParameter.new(:writing_intensive, 'WI')
LiberalEducationCourse.where([p])
```

Either of those will return a collection of 0 or more LiberalEducationCourse objects.

```ruby
c = CourseSearch.search(
  SearchParameters.parse('writing_intensive=true')
).first
c.id #=> "807690"
c.subject #=> "MATH"
c.catalog_number #=> "4067W"
c.title #=> "Actuarial Mathematics in Practice"
c.diversified_core #=> nil
c.designated_theme #=> nil
c.writing_intensive #=> true
```
