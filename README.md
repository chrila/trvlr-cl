# trvlr
trvlr is a platform where users can plan, document and share trips.
* Planning: create potential trip targets as waypoint and connect the dots. The current plan is illustrated on a map.
* Documenting: update the status of your route, write blog posts and upload photos while you are travelling. Such items are
  connected to waypoints, this way it's always straight forward and you don't have to sort anything when you come back home.
* Sharing: if you want your friends and family to see your trip, just set its visibility to "public" and share the link.
  Visitors don't have to register to see public items.

This is my final project of the bootcamp "Fullstack development - ruby on rails", generation 39, of
[Academia Desafío Latam](https://desafiolatam.com/).
The objective of this project was to create a platform to plan, document and share trips.

# Index
[Used versions](#used-versions) \
[Deployment](#deployment)

# Used versions
ruby: `3.0.1` \
rails: `6.1.4`

# Deployment
Deployment is pretty straight forward. You will need a running postgres server and the ruby and rails versions mentioned above under [used versions](#used-versions).

## Clone repository
```bash
git clone https://github.com/chrila/trvlr-cl.git
```

## Install dependencies
```bash
cd trvlr-cl
bundle install
yarn install
```

## Run migrations
Make sure that the postgres server is running.
```bash
rails db:migrate
```

## Run seed
If desired, you can populate the DB with test data.
```bash
rails db:seed
```

## Start the server
```bash
rails s
```

## Open website
http://localhost:3000
