# Gutenberg

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'gutenberg', :git => 'git://github.com/consti/gutenberg.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gutenberg

## Usage

Something like:

```ruby
catalog = Gutenberg::Catalog::Parser.new('catalog.rdf')
puts catalog.books.first.name
catalog.books.first.get_data.author.birthdate
catalog.books.first.get_data.downloads.first.url
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
