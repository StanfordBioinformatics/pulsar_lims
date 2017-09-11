#!/usr/bin/env /Users/nathankw/RailsApps/pulsar_lims/bin/rails runner

#require "json" #not needed since I added this to the Gemfile and RAILS already requires all gems when using rails runner.
require "optparse"
require "json"

SPECIES="Homo sapiens"

#Target.destroy_all

options = {}
OptionParser.new do |opts|
	opts.on("--infile [INFILE]",help="File containing DCC Target JSON records, one per line, to be imported into the 'targets' table.") do |infile|
		options[:infile] = infile
	end
end.parse!

admin = User.find_by(email: "admin@enc.com")

count = 0
File.open(options[:infile]).each do |line|
	rec = JSON.parse(line.chomp)	
	organism = rec["organism"]["scientific_name"]
	if organism != SPECIES
		next
	end
	params = {}
	params[:user_id] = admin.id
	encode_identifier = rec["@id"].split("/").last
	params[:encode_identifier] = encode_identifier
	if Target.find_by(encode_identifier: encode_identifier)
		next
	end
	params[:name] = rec["label"]
	#Using the label since it's unique and all entries have it. The 
	
	Target.create!(params)
end
puts count

