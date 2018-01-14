module Bip44
  module Ethereum
    def get_ethereum_address(path)
      node = @wallet_node.node_for_path(path)

      # from bitcoin public key to ethereum public key
      group = ECDSA::Group::Secp256k1
      public_key = ECDSA::Format::PointOctetString.decode(node.public_key.to_bytes, group) # a point
      ethereum_public = public_key.x.to_s(16) + public_key.y.to_s(16)

      # from ethereum public key to ethereum address
      bytes = Bip44::Utils.hex_to_bin(ethereum_public)
      address_bytes = Digest::SHA3.new(256).digest(bytes)[-20..-1]
      address = Bip44::Utils.bin_to_hex(address_bytes)
      Bip44::Utils.prefix_hex(address)
    end
  end
end