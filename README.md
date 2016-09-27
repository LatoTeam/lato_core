# Lato Core

## Installation

Add the lato_core gem on your Gemfile

```ruby
gem 'lato_core'
```
Install the gem

```console
bundle install
```

Generate the initializer (Rails 5)

```console
rails lato_core_initialize
```

Exec migrations

```console
bundle exec rake db:migrate
```

Now you can start the server and go to the relative url */lato/core*

You can access to the admin panel with these data:

* username: **lato**
* password: **password**

NB: You must install to work lato property **[lato_view](https://github.com/LatoTeam/lato_view)**

## Configuration (optional)

The gem lato_core can be configured with the file /config/lato/config.yml.

The config.yml file is created with the "lato_core_initialize" command and contain a list of important
settings.

## Develop with Lato Core

### Add a custom controller to the Lato panel

```ruby
class CustomController < ApplicationController

  layout 'lato_layout'
  before_action :core_controlUser

end
```

### Add a menu voice to the Lato panel

```yaml
menu:
  products:
    name: Products
    url: "/admin/products"
    icon: arrow-right
    position: 1
    permission: 0
```
