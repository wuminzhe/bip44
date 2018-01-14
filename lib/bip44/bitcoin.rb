module Bip44
  module Bitcoin
    def get_bitcoin_address(path)
      node = @wallet_node.node_for_path(path)
      node.to_address
    end
  end
end