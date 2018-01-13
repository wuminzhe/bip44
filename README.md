# ip44 for ruby

A ruby library to generate multi coin addresses from a hierarchical deterministic wallet according to the [BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki) standard.

Internally it uses [money-tree](https://github.com/GemHQ/money-tree) for the deterministic private and public keys which allows to use many additional features like deriving address from mnemonic backups (BIP32).

Compatible with most hd wallet client like: imToken，MetaMask，Jaxx，MyEtherWallet，TREZOR，Exodus...

I will add more coin support to it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bip44'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bip44

## Usage

See test

TODO: Write usage instructions here

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wuminzhe/bip44. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

