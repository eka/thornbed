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
    >> Thornbed.get("http://instagram.com/p/SOlosmBgoZ/")
    => {"provider_url"=>"http://instagram.com/",
     "media_id"=>"328365347227175449_43815385",
     "title"=>"Smile",
     "url"=>
      "http://distilleryimage1.instagram.com/b43af7ce329811e281d822000a1f9682_7.jpg",
     "author_name"=>"esteban108",
     "height"=>612,
     "width"=>612,
     "version"=>"1.0",
     "author_url"=>"http://instagram.com/",
     "author_id"=>43815385,
     "type"=>"photo",
     "provider_name"=>"Instagram"}

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
