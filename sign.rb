#!/usr/bin/env ruby

require './transaction_manager'
require 'optparse'
require 'ostruct'

def parse_arguments
	options = OpenStruct.new
	OptionParser.new do |opts|
		opts.banner = "This script is used to add new records or append to the existing records in the properties table."
		opts.on('-t', '--unsigned-tx unsigned_tx', String, "Unsigned Tx") { |t| options.unsigned_tx = t }
		opts.on('-p', '--private-key private_key', String, "Private Key") { |p| options.private_key = p }
	end.parse!
	options
end


options = parse_arguments

raise "Must provide unsigned tx with -t flag" if options.unsigned_tx.nil?
raise "Must provide private key with -p flag" if options.private_key.nil?

puts "\nSigned Tx:\n\n"
puts "{"
puts "  \"signed_tx\": \"#{TransactionManager.sign_tx(options.unsigned_tx, options.private_key)}\""
puts "}"