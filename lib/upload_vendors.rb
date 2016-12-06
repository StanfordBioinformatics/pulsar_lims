#!/usr/bin/env /Users/nathankw/RailsApps/snyder_encode/bin/rails runner

#require "json" #not needed since I added this to the Gemfile and RAILS already requires all gems when using rails runner.
require "optparse"

Vendor.delete_all

options = {}
OptionParser.new do |opts|
	opts.on("--infile [INFILE]",help="Full path to the tab-delimited input file containing the records from the ENCODE sources table to be imported into the vendors table. The column names must be 1) name, 2) title, 3) description, 4) url. See script to create this file at https://github.com/StanfordBioinformatics/encode/blob/master/dcc_submit/getEncodeVendors.py.") do |infile|
		options[:infile] = infile
	end
end.parse!

admin = User.find_by(email: "admin@enc.com")

fh = File.read(options[:infile])

json_data = JSON.parse(fh)

json_data.each do |x|
	params = {}
	params[:user_id] = admin.id
	params[:encode_identifier] = x["@id"].split("/").last
	params[:name] = x["title"] 
	params[:description] = x["description"]
	params[:url] = x["url"]
	Vendor.create!(params)
end
#json_data = JSON.parse(fh)
#if json_data.has_key?("@graph")
#	json_data = json_data["@graph"]
#end
#
#json_data.each do |x|
#	params = {}
#	params[:description] = x["description"]
#	params[:title] = x["title"]
#	params[:name] = x["name"]
#	params[:url] = x["url"]
#	Vendor.create!(params)
#end
