module Bip44
  module Bitcoin
    def get_bitcoin_address(index)
      node = @wallet_node.node_for_path("M/0/#{index}")
      node.to_address
    end
  end
end