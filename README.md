# Liberal Education Courses

Public endpoint for getting data about UMNTC courses that satisfy one or more liberal education requirements

## Querying on Liberal Education criteria

Full details on how you can use the query string to filter your results can be found at the [Query String Search page](https://github.com/umn-asr/query_string_search)

### Get all courses

https://liberal-education-courses.umn.edu/courses.json

### Get all courses with writing_intensive, designated_theme or diversified core

- https://liberal-education-courses.umn.edu/courses.json?q=writing_intensive=all
- https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=all
- https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=all

`all` and `true` are synonymous. So these could be written as:

- https://liberal-education-courses.umn.edu/courses.json?q=writing_intensive=true
- https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=true
- https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=true

### Get all courses without writing_intensive, designated_theme or diversified core

- https://liberal-education-courses.umn.edu/courses.json?q=writing_intensive=none
- https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=none
- https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=none

`none` and `false` are synonymous. So these could be written as:

- https://liberal-education-courses.umn.edu/courses.json?q=writing_intensive=false
- https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=false
- https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=false

### Get all courses that satisfy a specific designated theme or diversified core

- https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=dsj
- https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=ah

### Get all courses that satisfy one or more designated theme or diversified core

- https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=dsj|gp
- https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=ah|his|socs

## Querying on Subject

### Get all Liberal Education courses taught in JOUR

https://liberal-education-courses.umn.edu/courses.json?q=subject=JOUR

### Get all Liberal Education courses taught in JOUR or Asian American Studies

https://liberal-education-courses.umn.edu/courses.json?q=subject=JOUR|AAS

## Querying on Other Attributes

You can search based on any attribute returned in the JSON except for title. All of the below will work, but they won't return many courses.

- https://liberal-education-courses.umn.edu/courses.json?q=course_id=807690
- https://liberal-education-courses.umn.eduth,catalog_number=4067W

## Querying on More Than One Attribute

Separate attributes with a comma. Courses that match all providided attributes will be returned.

https://liberal-education-courses.umn.edu/courses.json?q=writing_intensive=true%2Csubject=JOUR

Will return courses that are writing intensive and that have the subject of JOUR

https://liberal-education-courses.umn.edu/courses.json?q=writing_intensive=true%2Cdiversified_core=ah

Will return courses that are writing intensive and that have the American History diversified core

https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=all%2Cdiversified_core=ah

Will return courses that meet any designated_theme and that have the American History diversified core

https://liberal-education-courses.umn.edu/courses.json?q=designated_theme=all%2Cdiversified_core=ah|litr

Will return courses that meet any designated_theme and that have either the American History or Literature diversified core

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
https://liberal-education-courses.umn.edu/courses.json?q=diversified_core=basketweaving
#=> {"courses": []}
```

And if you try to filter with invalid syntax, you'll get all courses back

```
https://liberal-education-courses.umn.edu/courses.json?q=easy_a
```
will be the same as
```
https://liberal-education-courses.umn.edu/courses.json
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
