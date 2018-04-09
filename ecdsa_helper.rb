require 'ecdsa'
require 'securerandom'
require 'digest'

module EcdsaHelper
  
  def self.str_to_hex(str)
    str.unpack('H*')[0]
  end
  
  def self.hex_to_str(str)
    [str].pack('H*')
  end
  
  def self.random_private_key
    res = 1 + SecureRandom.random_number(ECDSA::Group::Secp256k1.order - 1)
    res.to_s(16)
  end
  
  def self.sign(private_key, data_digest)
    signature = nil
    while signature.nil?
      signature = ECDSA.sign(
        ECDSA::Group::Secp256k1, 
        private_key.to_i(16), 
        data_digest, 
        random_private_key.to_i(16)
      )
    end
    str_to_hex ECDSA::Format::SignatureDerString.encode(signature)
  end
  
end