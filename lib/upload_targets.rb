#!/usr/bin/env /Users/nathankw/RailsApps/pulsar/bin/rails runner

#require "json" #not needed since I added this to the Gemfile and RAILS already requires all gems when using rails runner.
require "optparse"
require "json"

SPECIES="Homo sapiens"

Target.destroy_all

options = {}
OptionParser.new do |opts|
	opts.on("--infile [INFILE]",help="Full path to input file containing JSON to import into the human genes portion from ENCODE's targets table. The JSON targets can be retrieved via the URL https://www.encodeproject.org/targets/?format=json&limit=all.") do |infile|
		options[:infile] = infile
	end
end.parse!

admin = User.find_by(email: "admin@enc.com")

fh = File.read(options[:infile])
json_data = JSON.parse(fh)
#if json_data.has_key?("@graph")
#	json_data = json_data["@graph"]
#end

count = 0
json_data.each do |x|
	organism = x["organism"]["scientific_name"]
	if organism != SPECIES
		next
	end
	params = {}
	params[:user_id] = admin.id
	params[:encode_identifier] = x["@id"].split("/").last
	params[:name] = x["label"]
	#Using the label since it's unique and all entries have it. The 
	
	Target.create!(params)
end
puts count

