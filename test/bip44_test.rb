require "test_helper"

class Bip44Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bip44::VERSION
  end

  def test_get_addresses_from_wallet
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'")
    first_address = first_wallet.get_ethereum_address("M/0/0")

    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_create_wallet_from_mnemonic
    words = "actress chest crazy extend alley tag firm drive renew notice confirm hand"
    first_wallet = Bip44::Wallet.from_mnemonic(words, "m/44'/60'/0'")
    first_address = first_wallet.get_ethereum_address("M/0/0")

    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_create_wallet_from_xpub
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'")
    xpub = first_wallet.xpub

    wallet = Bip44::Wallet.from_xpub(xpub)
    first_address = wallet.get_ethereum_address("M/0/0")
    assert_equal first_address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end

  def test_get_bitcoin_address
    seed = "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"
    first_wallet = Bip44::Wallet.from_seed(seed, "m/44'/0'/0'")
    xpub = first_wallet.xpub

    wallet = Bip44::Wallet.from_xpub(xpub)
    first_address = wallet.get_bitcoin_address("M/0/0")
    assert_equal first_address, "1Kn4i7KeCrypPtjBZ6TmVFVCSiBsV7u3VW"
  end

  # just for show the way I use to complete the gem
  def test_it_can_create_a_new_ethereum_address_from_mnemonic
    words = BipMnemonic.to_mnemonic(bits: 128) # 1. 生成一个助记词（参见 BIP39）
    words = "actress chest crazy extend alley tag firm drive renew notice confirm hand"
    seed = BipMnemonic.to_seed(mnemonic: words) # 2. 该助记词使用 PBKDF2 转化为种子（参见 BIP39）
    master = MoneyTree::Master.new(seed_hex: seed) # 3. 种子用于使用 HMAC-SHA512 生成根私钥（参见 BIP32）
    node = master.node_for_path("m/44'/60'/0'/0/0") # 4. 从该根私钥，导出子私钥（参见 BIP32），其中节点布局由BIP44设置

    ## seed
    assert_equal seed, "895f9fe6ea00db7f97ff181e21b4303c0246e8342c3775b935ed41e7841e4234aa0331866f1931a8b5d56d7f49f6323ffb91aaaccc9522b2dbfb14aaf6960f73"

    ## private key
    private_key = node.private_key.to_hex
    assert_equal private_key, "e0eb65e1b1f9849bc7849ce24f6825f366742a736f6f5dd55ba08fe0697d6d83"

    ## ethereum address
    group = ECDSA::Group::Secp256k1
    public_key = ECDSA::Format::PointOctetString.decode(node.public_key.to_bytes, group) # a point
    ethereum_public = public_key.x.to_s(16) + public_key.y.to_s(16)

    bytes = Bip44::Utils.hex_to_bin(ethereum_public)
    address_bytes = Digest::SHA3.new(256).digest(bytes)[-20..-1]
    address = Bip44::Utils.bin_to_hex(address_bytes)
    address = Bip44::Utils.prefix_hex(address)
  
    assert_equal address, "0xf35d683226da7cc652299ea5f8798f1a8e8812cf"
  end
end
