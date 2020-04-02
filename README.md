## Installation:

### First setup:

1) `docker-compose build`
2) `docker-compose up`
3) `docker-compose run --rm app rake db:reset` (In alternative terminal tab)
4) Got to http://localhost:3000/api/swagger/

### Regular Run:

1) `docker-compose up`
2) Got to http://localhost:3000/api/swagger/

### Run specs:

1) `docker-compose run --rm app rspec spec/`

'mysql:5.7' Image should be run. You can check it with command `docker ps`. If in returned list you can't find image 'mysql:5.7' with name like 'users_programs_db_1', you can make next steps:

1) `docker-compose up`
2) `docker-compose run --rm app rspec spec/` (In alternative terminal tab)








