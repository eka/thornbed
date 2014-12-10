# Thornbed

Thornbed provides a single interface to get embeddable content from many sites, even sites with no OEmbed support.

## Installation

Add this line to your application's Gemfile:

    gem 'thornbed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thornbed

## Usage

    >> require "thornbed"
    => true
    >> Thornbed.get("http://imgur.com/DHe9T")
    => {"url"=>"http://i.imgur.com/DHe9T.jpg",
     "type"=>"photo",
     "provider_name"=>"Imgur",
     "provider_url"=>"http://imgur.com",
     "thumbnail_url"=>"http://i.imgur.com/DHe9Ts.jpg",
     "version"=>"1.0",
     "page"=>"http://imgur.com/DHe9T",
     "width"=>nil,
     "height"=>nil}

## Adding new providers

See ruby-oembed on this. Don't forget to call `OEmbed::Providers.register_all`

## Creating your custom providers

You should inherit from `Thornbed::Providers::Provider`. See imgur.rb for an example.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Contributors

* [frodsan](https://github.com/frodsan)
