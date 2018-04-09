require "./ecdsa_helper"
require 'json'

class TransactionManager
  
  def self.sign_tx(serialized_tx, private_key)
    JSON.parse([serialized_tx].pack('H*'))
    txn_attributes = deserialize(serialized_tx)
    txn_attributes["sender_signature"] = EcdsaHelper.sign(private_key, txn_attributes["id"])
    return serialize(txn_attributes)
  end
  
  def self.serialize(json)
    EcdsaHelper.str_to_hex(json.to_json)
  end
  
  def self.deserialize(serialized_tx)
    JSON.parse(EcdsaHelper.hex_to_str(serialized_tx))
  end
  
end



