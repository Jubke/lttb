# lttb - Largest-Triangle-Three-Buckets (Ruby)
This is an implementation of the Largest-Triangle-Three-Buckets (LTTB) downsampling algorithm in Ruby.

The code has been translated from the work of Sveinn Steinarsson in his plugin for Flot charts.
More information is available on [his page](https://github.com/sveinn-steinarsson/flot-downsample/),
and you can find the thesis describing the algorithm [here](http://skemman.is/handle/1946/15343).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lttb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lttb

## Usage

Data passed should be in the format [[x1,y1],[x2,y2]].
```ruby
  data = [[1, 1], [2, 4], [3, 9], [4, 16], [5, 25]]
  threshold = 3
  Lttb.process(data, threshold)
  # => [1, 1], [3, 9], [5, 25]]
```

Pass an `:dates => true` to process DateTime objects correctly.
```ruby
  Lttb.process(data, threshold, dates: true)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Jubke/lttb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

