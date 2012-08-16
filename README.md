# logbang

Logbang provides `log!`, which is `Rails.logger.debug` on steroids.

Logbang allows you to scatter `log!` calls throughout your Rails
application (views, controller, helpers) and appends the message to the
logs in a pretty, coloured format.

It also keeps track of the timing information, and generates a timing
table at the end of the request showing the time between calls, and
unique tokens you can use to jump directly to the relevant position in
the logs.

It is useful for any kind of debugging where navigating full stack
traces is hard, or where you are hunting performance issues and want to
selectively drill down into pieces of your code, rather than profile the
entire execution.

It's also great for wrapping around a piece of functionality to be able
to pinpoint which SQL queries are related.

## Installation

Add this line to your application's Gemfile:

    gem 'logbang'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logbang

## Usage

Simply call `log!` (with a message or without) anywhere that is called
in the context of +ActionController::Base+ (controller, views, helpers).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
