# Liberal Education Courses

Public endpoint for getting data about courses that satisfy one or more liberal education requirements

## Get all courses

https://liberal_education.umn.edu/courses.json

## Get all courses that satisfy Writing Intensive

https://liberal_education.umn.edu/courses.json?q=writing_intensive=true

## Get all courses that satisfy a designated theme

https://liberal_education.umn.edu/courses.json?q=designated_theme=dsj

## Get all courses that satisfy a specific diversified core

https://liberal_education.umn.edu/courses.json?q=diversified_core=ah

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
    "writing_intensive": true
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
    "writing_intensive": false
  }]
}

```

An empty courses collection will be returned if no courses match your criteria

```
https://liberal-education.umn.edu/courses.json?q=diversified_core=basketweaving
#=> {"courses": []}

https://liberal-education.umn.edu/courses.json?q=easy_a
#=> {"courses": []}
```

## Limits

- If a course is cross-listed under multiple subject/catalog numbers, then it will appear in the results multiple times.
- Data comes from the Data Warehouse, so it is a day old.

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
CourseSearch.search('writing_intensive=true')
CourseSearch.search('diversified_core=ah')
CourseSearch.search('designated_theme=civ')
```

Or this nicer syntax

```ruby
LiberalEducationCourse.writing_intensive
LiberalEducationCourse.diversified_core('AH')
LiberalEducationCourse.designated_theme('civ')
```

Either of those will return a collection of 0 or more LiberalEducationCourse objects.

```ruby
c = LiberalEducationCourse.writing_intensive.first
c.id #=> "807690"
c.subject #=> "MATH"
c.catalog_number #=> "4067W"
c.title #=> "Actuarial Mathematics in Practice"
c.diversified_core #=> nil
c.designated_theme #=> nil
c.writing_intensive #=> true
```
