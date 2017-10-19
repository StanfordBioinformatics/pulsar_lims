#!/usr/bin/env /Users/nathankw/RailsApps/pulsar_lims/bin/rails runner

#require "json" #not needed since I added this to the Gemfile and RAILS already requires all gems when using rails runner.
require "optparse"
require "json"

SPECIES="Homo sapiens"
#BATCH_SIZE=300

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
	params[:name] = rec["label"]
	params[:encode_identifier] = encode_identifier
	xrefs = rec["dbxref"]
	xrefs.each do |ref|
		if ref.start_with?("ENSEMBL")
			params[:ensembl] = ref.split("ENSEMBL:")[-1].strip()
			break
		end
	end
	target = Target.find_by(encode_identifier: encode_identifier)
	if target.present?
		target.update(params)
	else
		#Using the label since it's unique and all entries have it. The 
		Target.create!(params)
	end
end
puts count

