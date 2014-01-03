# Devise Encryptable

[![Build Status](https://api.travis-ci.org/plataformatec/devise-encryptable.png)](https://travis-ci.org/plataformatec/devise-encryptable)

Use alternative (and even your own!) encryptors with Devise.

## Usage

Add it to your Gemfile

```ruby
gem "devise-encryptable"
```

Add the `encryptable` module to your model:

```ruby
class User < ActiveRecord::Base
  devise :database_authenticatable, :encryptable
end
```

And add the `password_salt` field to the database through a migration:


```ruby
class DeviseCreateUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_salt, :string
  end
end
```

And you're ready to go!

## Contributing

* Fork it
* Write your changes
* Commit
* Send a pull request

## License

Apache License version 2. Copyright 2012-2014 Plataformatec http://plataformatec.com.br
