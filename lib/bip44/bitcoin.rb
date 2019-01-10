module Bip44
  module Bitcoin
    def bitcoin_address(testnet: false)
      return @wallet_node.public_key.to_address(network: :bitcoin_testnet) if testnet
      @wallet_node.public_key.to_address
    end
  end
end
