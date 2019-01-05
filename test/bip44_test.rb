require "test_helper"
require "execjs"
require "open-uri"

class Bip44Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bip44::VERSION
  end

  def test_get_addresses_from_wallet
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'")
    first_address = first_wallet.sub_wallet("M/0/0").ethereum_address

    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_create_wallet_from_mnemonic
    words = "actress chest crazy extend alley tag firm drive renew notice confirm hand"
    first_wallet = Bip44::Wallet.from_mnemonic(words, "m/44'/60'/0'")
    first_address = first_wallet.sub_wallet("M/0/0").ethereum_address

    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_create_wallet_from_xpub
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'/0")
    xpub = first_wallet.xpub

    wallet = Bip44::Wallet.from_xpub(xpub)
    first_address = wallet.sub_wallet("M/0").ethereum_address
    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_create_wallet_from_xprv
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'/0")
    xprv = first_wallet.xprv

    wallet = Bip44::Wallet.from_xprv(xprv)
    first_address = wallet.sub_wallet("M/0").ethereum_address
    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_get_bitcoin_address
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/0'/0'")
    xpub = first_wallet.xpub

    wallet = Bip44::Wallet.from_xpub(xpub)
    first_address = wallet.sub_wallet("M/0/0").bitcoin_address
    assert_equal first_address, "1Kn4i7KeCrypPtjBZ6TmVFVCSiBsV7u3VW"
  end

  def test_to_wif
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    wallet = Bip44::Wallet.from_seed(seed, "m/44'/0'/0'")

    assert_equal wallet.wif, 'L5BFS3WxaL5snVnmd9Q2Yw6eLPukbk9xsicWzaHoPAZLYAJYUmui'
  end

  def test_bitcoin_testnet_wif
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    wallet = Bip44::Wallet.from_seed(seed, "m/44'/0'/0'")

    assert_equal wallet.wif(compressed: false, testnet: true), '93PV54y9PHwdh63W18JFi4m7ZYKAMD4mr7HmCnFoCAZhjcaEVap'
  end

  # noise present panda vault cloth uniform possible crew defense village appear two
  # ethereum xprv: xprvA1H7VdxfPaj8rwF8j5hh2Mbx6Ea76CG6kXf8zArBNjFnUyDzNvqMvJdM5auYod6wFDEPrzJNAaSgS64e99RAxvDRzgT3PHmK1uUuR6AGaui
  # ethereum xpub: xpub6EGTu9VZDxHS5RKbq7EhPVYgeGQbVeyx7kajnZFnw4nmMmZ8vU9cU6wpvrnZv4uAttdmxztoyPpxn71WobTmhM4HyEppFWCznwtHLxPwQqG
  # bitcoin xprv: xprvA1zwXTHDVEgLqW4kteFnf9FQqTx5swYMGM8QMJULRwQcmAxxBdJoRLhkwuxVscmAWK7tubZ9oJCEX9TxZTamPa41PU2LMZyA51tzU39esg7
  # bitcoin xpub: xpub6EzHvxp7KcEe3z9Dzfno2HC9PVnaHQGCda419gswzGwbdyJ6jAd3y92Eo9fJEZV8Q7Rm92ZSHM7C9kHW86N2qSvmjNHAzM8kfYzKBPKTsB3
  def test_derive_child_wallet
    addresses = []
    path = File.join(File.dirname(__FILE__), 'addresses.txt')
    File.open(path).read.each_line do |line|
      addresses << line.strip
    end
    xpub = "xpub6EPbauBbH3SYLqJrdPAK8yQuyQDow7pY4HDV8SMezH3VVb5g5htLpMAb7gvFXVdXPRp6m2fYHc1J3bjurfbfRd2DuNZQ9rKKiKAPirbj3F7"
    wallet = Bip44::Wallet.from_xpub(xpub)

    addresses.each_with_index do |address, i|
      sub_wallet = wallet.sub_wallet("M/#{i}")
      assert_equal sub_wallet.ethereum_address, address
    end
    
  end
end
