# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bip44/version"

Gem::Specification.new do |spec|
  spec.name          = "bip44"
  spec.version       = Bip44::VERSION
  spec.authors       = ["wuminzhe"]
  spec.email         = ["wuminzhe@gmail.com"]

  spec.summary       = "A ruby library to generate Ethereum addresses from a hierarchical deterministic wallet according to the BIP44 standard."
  spec.description   = "A ruby library to generate Ethereum addresses from a hierarchical deterministic wallet according to the BIP44 standard."
  spec.homepage      = "https://github.com/wuminzhe/bip44"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "execjs", "~> 2.4.0"

  spec.add_dependency "money-tree"
  spec.add_dependency "ecdsa", "~> 1.2.0"
  spec.add_dependency "digest-sha3", "~> 1.1.0"
  spec.add_dependency "rlp", "~> 0.7.3"
  spec.add_dependency "bip_mnemonic"
  spec.add_dependency "eth"
end
