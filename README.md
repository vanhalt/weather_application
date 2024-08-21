# Weather Application

READMEs:

-   weather_app/README.md
-   addresses_api/README.md

# Running project

```bash
docker compose up -d # for database and redis services
```

-   addresses API

```bash
cd addresses_api

bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails s -p 3001
```

-   Weather app

```bash
cd weather_app/

bundle install
bundle exec rails s
```
