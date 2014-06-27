FROM:amos6224/postgres

  RUN apt-get update
  RUNsleep 10
  RUN apt-get install -y git
  RUNapt-get install -y imagemagick libxslt1-dev libxml2-dev libpq-dev
  RUN cp config/database.drone.yml config/database.yml
  RUN cp .env.example .env
  RUN psql -c 'create database test;' -U root -h 127.0.0.1
  RUN RAILS_ENV=test bundle exec rake db:schema:load
  RUN RAILS_ENV=test bundle exec rspec spec

notify:
  email:
    recipients:
      - jeff@namely.com
      - attila@namely.com

  hipchat:
    room: CI
    token: {{hipchat_token}}
    on_started: true
    on_success: true
    on_failure: true
