# Liberal Education Courses

Public endpoint for getting data about courses that satisfy one or more liberal education requirements

## Get all courses

https://liberal_education.umn.edu/courses

## Get all courses that satisfy Writing Intensive

https://liberal_education.umn.edu/courses/writing_intensive

## Get all courses that satisfy any designated theme 

https://liberal_education.umn.edu/courses/designated_theme

## Get all courses that satisfy a specific designated theme 

https://liberal_education.umn.edu/courses/designated_theme/DSJ

## Get all courses that satisfy any diversified core

https://liberal_education.umn.edu/courses/diversified_core

## Get all courses that satisfy a specific diversified core

https://liberal_education.umn.edu/courses/diversified_core/ah

## Combine Them

`https://liberal_education.umn.edu/courses/writing_intensive/designated_theme/civ`

Returns all courses that satisfy Writing Intensive and the Civic Life theme.

`https://liberal_education.umn.edu/courses/designated_theme/civ/diversified_core`

Returns all courses that satisfy the Civic Life theme and any diversified core.

`https://liberal_education.umn.edu/courses/designated_theme/civ/diversified_core/his`

Returns all courses that satisfy the Civic Life theme and the Historical Perspectives diversified core.

https://liberal_education.umn.edu/courses/designated_theme/civ/diversified_core/his/writing_intensive

Returns all courses that satisfy the Civic Life theme, the Historical Perspectives diversified core and are Writing Intensive

## Return Values

Only returns JSON. Limited course data

```json

{
  "courses": [{
    "id": "807690",
    "subject": "MATH",
    "catalog_number": "4067W",
    "title": "Actuarial Mathematics in Practice",
    "diversified_core": null,
    "designated_theme": null,
    "writing_intensive": true
  },{
    "id": "808233",
    "subject": "JOUR",
    "catalog_number": "3775",
    "title": "Administrative Law and Regulation for Strategic Communication",
    "diversified_core": null,
    "designated_theme": "CIV",
    "writing_intensive": false
  }]
}

```

## Limits

- If a course is cross-listed under multiple subject/catalog numbers, then it will appear in the results multiple times.
- You can not have two (or more) designated themes or diversified cores is a query.
  - Meaning you can't ask "Show me all courses that meet either Literature or Social Sciences"
- Data comes from the Data Warehouse, so it is a day old.

## Console Interaction

```ruby
LiberalEducationCourses.writing_intensive
LiberalEducationCourses.diversified_core
LiberalEducationCourses.diversified_core('AH')
LiberalEducationCourses.designated_theme
LiberalEducationCourses.designated_theme('civ')
LiberalEducationCourses.diversified_core.designated_theme('civ')
LiberalEducationCourses.diversified_core.writing_intensive
LiberalEducationCourses.diversified_core('AH').diversified_core.designated_theme('civ')
```

All of those will return a collection of 0 or more LiberalEducationCourse objects.

```ruby
c = LiberalEducationCourses.writing_intensive.first
c.id #=> "807690"
c.subject #=> "MATH"
c.catalog_number #=> "4067W"
c.title #=> "Actuarial Mathematics in Practice"
c.diversified_core #=> nil
c.designated_theme #=> nil
c.writing_intensive #=> true
```

## Reference

### IDs for Diversified Cores

* You can pass these in all caps, all lower-case, mixed caps, etc. But they will be all caps in the returned json *

- Ah: Arts & Humanities
- Biol: Biological Sciences
- His: Historical Perspectives
- Litr: Literature
- Math: Mathematical Thinking
- Phys: Physical Sciences
- Socs: Social Sciences

### IDs for Designated Theme

* You can pass these in all caps, all lower-case, mixed caps, etc. But they will be all caps in the returned json *

- Gp: Global Perspectives
- Ts: Technology and Society
- Civ: Civic Life and Ethics
- Dsj: Diversity and Social Justice in the U.S.
- Env: The Environment

## Implementation Notes

- LiberalEducationCourses queries are built on CourseRepository
- CourseRepository implements .all and way to query on these attributes
- Backend uses the Rails memory cache
  - Only want to query the db once a day

- Somewhere in here is a set of course structs. 

`[{id: 1, subject:}...]`

From that, we can build sub sets

```
all_theme = courses.select { |c| c.designated_theme }.to_set
by_theme = all_theme.classify { |c| c.designated_theme }

all_core = courses.select { |c| c.diversified_core }.to_set
by_core = all_core.classify { |c| c.designated_theme }

wi = courses.select { |c| c.writing_intensive? }.to_set
```

Queries should just then be a matter of set intersections

```
theme['GP'] & wi & all_core
```


