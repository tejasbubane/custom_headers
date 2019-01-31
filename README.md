# rack_custom_headers

[![Build Status](https://travis-ci.org/tejasbubane/rack_custom_headers.svg?branch=master)](https://travis-ci.org/tejasbubane/rack_custom_headers)

Custom headers for your rack app.

This simple rack middleware will allow you to easily add custom headers to your request/response.

## Installation

```ruby
gem 'rack_custom_headers'
```

## Usage

#### Rails apps

In `config/application.rb`:

```
config.middleware.use Rack::CustomHeaders <hash options with headername and generator proc>
```

eg.

```ruby
config.middleware.use Rack::CustomHeaders, "X-Trace-ID" => -> { SecureRandom.hex(10) }, "X-Foo" => -> :default
```

Refer [docs](https://guides.rubyonrails.org/rails_on_rack.html#configuring-middleware-stack) for more details.

#### Non-Rails apps

In `config.ru`:

```ruby
use Rack::RequestID <hash options same as above>
```

### Config

* Headers will only be added. If header already present, it will **not** be overridden.

* A config hash is mandatory to be passed in `use` otherwise nothing will be added.

* Config hash should be of the format `"header-name" => -> { ... }` or `"header-name" => :default`.

* When symbol `:default` is passed instead of proc, a new `UUID` will be generated and added.
