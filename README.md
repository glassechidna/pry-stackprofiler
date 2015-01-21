# Pry-Stackprofiler

Please read the [`stackprofiler`][1] gem README for background on Stackprofiler
in general.

This is a [Pry][2] plugin that makes benchmarking of code using Stackprofiler a
much more fluid experience and provide a quicker turn-around time. It does
this by passing along Pry's linebuffer to the Stackprofiler server so that
code needn't be stored in the file system for Stackprofiler to annotate.

## Installation

    $ gem install pry-stackprofiler

Once installed, Pry should autoload the plugin. No `require` necessary. There is
some setup required on the plugin side; specifically, the plugin needs to be told
where to send profile data. This can be done either by means of an environment
variable or in `~/.pryrc`.

```ruby
# ~/.pryrc
Pry.config.pry_stackprofiler_ui_url = "http://localhost:9292/receive"
```

or

```bash
# ~/.bashrc
export PRY_STACKPROFILER_UI_URL=http://localhost:9292/receive
```

## Usage

Start up Stackprofiler on the command line:

    $ stackprofiler

In another tab, start up a Pry session:

    $ pry
    [1] pry(main)> Pry.profile do
    [1] pry(main)*   sleep 0.3
    [1] pry(main)*   sleep 0.4
    [1] pry(main)*   sleep 0.1
    [1] pry(main)* end

Now navigate to Stackprofiler (probably at [http://localhost:9292/][3])
and see which lines were slowest!

You can pass an options hash to `Pry::profile` if desired. The most useful key is `interval`
and specifies how often the code should be sampled in microseconds. The default is 1000.

## Contributing

1. Fork it ( https://github.com/glassechidna/pry-stackprofiler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[1]: https://github.com/glassechidna/stackprofiler
[2]: https://github.com/pry/pry
[3]: http://localhost:9292/
