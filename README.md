![Hexlet-check](https://github.com/yarrman2/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)
![CI status](https://github.com/yarrman2/rails-project-63/actions/workflows/main.yml/badge.svg)

# HexletCode

Gem for the easy creating HTML form 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ make install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

```ruby 
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = user.new job: 'hexlet'
form = hexletcode.form_for user, url: '#' do |f|
    f.input :name
    f.input :job
    f.submit 'wow'
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input type="text" name="name" value="">
#   <label for="job">Job</label>
#   <input type="text" name="job" value="hexlet">
#   <input type="submit" value="Wow">
# </form>

```

## Development

```make install```
To install dependencies

```make lint```
Style linting

```make lint-fix```
Style linting with fixing

```make test-project```
start tests
