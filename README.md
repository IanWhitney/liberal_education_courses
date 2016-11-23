# Liberal Education Courses

http://liberal-education-courses.umn.edu provides Liberal Education course data for all system campuses.

## Routes

| Endpoint | Data |
| ---- | ---- |
| http://liberal-education-courses.umn.edu | All campuses |
| http://liberal-education-courses.umn.edu/campuses | All campuses |
| http://liberal-education-courses.umn.edu/campuses/:campus_id | Single campus |
| http://liberal-education-courses.umn.edu/campuses/:campus_id | Single campus |
| http://liberal-education-courses.umn.edu/campuses/:campus_id/groups | Liberal Education requirement groups for a campus\* |
| http://liberal-education-courses.umn.edu/groups/:group_id/requirements | Liberal Education requirement requirements that fall under a group |
| http://liberal-education-courses.umn.edu/campuses/:campus_id/requirements | Liberal Education requirements for a campus |
| http://liberal-education-courses.umn.edu/campuses/:campus_id/courses | Courses that satisfy a campus' lib ed requirements |

\* Not all campuses use requirement groups.

The useful route is the last one. Data returned for each course looks like

```json
{
  "id": "002832",
  "type": "courses",
  "links": {
    "self": "http://liberal-education-courses.umn.edu/courses/002832"
  },
  "attributes": {
    "subject": "ART",
    "catalog-number": "1152",
    "title": "Drawing and Design",
    "satisfied-requirements": [
      {
        "id": 206,
        "name": "Goal 6 - Humanities: Arts, Literature, Philosophy",
        "abbreviation": "HUMANITIES",
        "group": {}
      }
    ],
      "term": {
      "name": "Spring, 2017"
    }
  }
}
```

| attribute | description | 
| ----  | ---- |
| id | Course Id, same as what's in PeopleSoft |
| subject | The course's subject abbreviation | 
| catalog-number | The official catalog number, same as what's in PeopleSoft |
| title | Course title |
| satisfied-requirements | A collection of Lib Ed requirements this course satisfies |
| requirement: name | The full name of the requirement satisfied |
| requirement: abbreviation | The short name of the requirement satisfied |
| group: name | The group the requirement belongs to, if any |
| term | The term for which the course satisfies these requirements |

The term is important. A course may satisfy a Liberal Education requirement this term, but not next. Or vice versa. This service only shows data for a single term at a time, and it is not currently possible to see what courses satisfied Lib Ed requirements for other terms.

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
