# Device Reader

* Ruby 3.3.1
* Rails 7.1.3

## Installation 

### Install Homebrew
https://brew.sh/
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install asdf (or your ruby version manager of choide)
```shell
brew install asdf
```

### Install ruby
```shell
asdf install ruby 3.3.1
```

### Install postgres
```shell
brew install postgresql@14
brew services start postgresql@14
```

### Install redis
```shell
brew install redis
redis-server
```

### Bundle
```shell
bundle install
```

### Create DB
```shell
bin/rails db:create
```

### Run Server
```shell
bin/rails s
```

## Usage
API allows posting new readings and fetching device information. Server uses ohm to
store model like data in Redis.

### Create/Add Readings
POST "/devices/readings"
```json
{
    "id": "36d5658a-6908-479e-887e-a949ec199272",
    "readings": [
                    {
                        "timestamp": "2021-09-29T16:08:15+01:00",
                        "count": 2
                    },
                    {
                        "timestamp": "2021-09-29T16:09:15+01:00",
                        "count": 15
                    }   
                ]
}
```

Accepts array of readings. "id" and "readings" are required. Invalid readings
will be ignored as will duplicate readings based on timestamp.

### Fetch Device Info
GET "/devices/:id"

"id" is required as query param. 401 will be raised if not found. Returned JSON:
```json
{
    "id": "36d5658a-6908-479e-887e-a949ec199272",
    "cumulative_count": "84",
    "latest_timestamp": "2021-09-29T16:09:15+01:00"
}
```

## Project Structure
Basic Rails API.

Postgres was included but isn't utilized so it could be removed. Assumption was that
there would still potentially be user and/or auth info stored somewhere.

Controllers focused on requests and responses.

OHM models created to utilize Redis backend for in-memory storage. This allows
for attribute declarations, lookups and associations, etc.

Simple Service class created for processing new Readings.

## Improvements

#### Write specs
With ~2 hour time limit, didn't have time to spec this all out.
#### Timestamp parsing. 
Currently expects a valid timestamp string.

#### Reading limit per request
Not sure what a reasonable amount of readings would be. Could make endpoint
asynchronous with Sidekiq (or similar) and process readings in background while returning a 202 accepted.

#### Validation
Ignores invalid readings right now, but it could return an error if preferred. 

#### More GET endpoints
It seemed simplest to just return all pertinent info in a single Device endpoint. These could
be broken out if necessary/required.

#### In-memory requirement
Would need to know more about the reasoning of this restriction. Do we instead
need an in-memory DB?  Are we just worried about query speed and should implement 
something like Elasticsearch while still persisting data to a standard DB?