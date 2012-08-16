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

It will create log entries that look like this:

```
 = Marked: container-start - 4380ee5
```

They'll be bright yellow, so you can't miss them!

At the end of a successful request, a table with timing information will
be output :

```
 = 56e83ce @     0ms (+    0ms)  /app/views/agreements/index.html.erb
 = 8933225 @   391ms (+  391ms)    helper-start
 = 8dc03cc @   444ms (+   53ms)    helper-end
 = 4380ee5 @   625ms (+  180ms)  container-start
 = bcec099 @   694ms (+   69ms)  container-end
```

Note that the random ID in the first column of the table match up with
the individual log lines so as that you can easily find them. They
change every request so the chances of having multiple matches is
reduced.

The second column shows the time since the first call to `log!`, and the
third column is the delta from the previous log entry. Both these values
are incredibly helpful when you're hunting of debugging performance
issues, or testing optimisations.

Where possible, logbang will indent subsequent calls to log when it can
work out that they are nested. Currently this is fairly naive, and can
only make the match when the files are the direct caller (eg. a view
calling a helper, or a helper calling another helper).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
