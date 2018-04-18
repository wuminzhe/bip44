module Bip44
  module Bitcoin
    def get_bitcoin_address(path)
      node = @wallet_node.node_for_path(path)
      node.to_address
    end

    def bitcoin_address
      @wallet_node.public_key.to_hex
    end

    def public_key
      @wallet_node.public_key.to_hex
    end
  end
end