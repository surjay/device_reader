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
