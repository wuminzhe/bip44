module Bip44
  module Ethereum
    def get_ethereum_address(path)
      sub_wallet = sub_wallet(path)
      sub_wallet.ethereum_address
    end

    def get_child_ethereum_address(index)
      sub_wallet = sub_wallet()
      sub_wallet.ethereum_address
    end

    def ethereum_address
      # from bitcoin public key to ethereum public key
      group = ECDSA::Group::Secp256k1
      public_key = ECDSA::Format::PointOctetString.decode(@wallet_node.public_key.to_bytes, group) # a point
      ethereum_public = Utils.padding64(public_key.x.to_s(16)) + Utils.padding64(public_key.y.to_s(16))

      # from ethereum public key to ethereum address
      bytes = Bip44::Utils.hex_to_bin(ethereum_public)
      address_bytes = Digest::SHA3.new(256).digest(bytes)[-20..-1]
      address = Bip44::Utils.bin_to_hex(address_bytes)
      Bip44::Utils.prefix_hex(address)
    end
  end
end