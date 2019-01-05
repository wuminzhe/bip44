module Bip44
  module Bitcoin
    def bitcoin_address(network: :bitcoin)
      @wallet_node.public_key.to_address(network: network)
    end
  end
end
