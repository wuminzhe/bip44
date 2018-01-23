require "bip44/version"
require 'ecdsa'
require 'digest/sha3'
require 'rlp'
require 'money-tree'
require 'bip_mnemonic'
require 'bip44/utils'
require 'bip44/bitcoin'
require 'bip44/ethereum'
require 'bip44/wallet'

module Bip44
  def self.create_mnemonic_wallet
    words = BipMnemonic.to_mnemonic(bits: 128)
    puts words
    seed = BipMnemonic.to_seed(mnemonic: words)
    ethereum_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'/0")
    puts 'ethereum xprv: ' + ethereum_wallet.xprv
    puts 'ethereum xpub: ' + ethereum_wallet.xpub
    bitcoin_wallet = Bip44::Wallet.from_seed(seed, "m/44'/0'/0'/0")
    puts 'bitcoin xpub: ' + bitcoin_wallet.xpub
  end

  def self.from_mnemonic(words)
    seed = BipMnemonic.to_seed(mnemonic: words)
    ethereum_wallet = Bip44::Wallet.from_seed(seed, "m/44'/60'/0'/0")
    puts 'ethereum xprv: ' + ethereum_wallet.xprv
    puts 'ethereum xpub: ' + ethereum_wallet.xpub
    bitcoin_wallet = Bip44::Wallet.from_seed(seed, "m/44'/0'/0'/0")
    puts 'bitcoin xprv: ' + bitcoin_wallet.xprv
    puts 'bitcoin xpub: ' + bitcoin_wallet.xpub
  end
end
