
#require "json" #not needed since I added this to the Gemfile and RAILS already requires all gems when using rails runner.
require "optparse"
require "json"

options = {}
OptionParser.new do |opts|
	opts.on("--infile [INFILE]",help="Full path to input file containing JSON to import into the human genes portion from ENCODE's targets table. The JSON targets can be retrieved via the URL https://www.encodeproject.org/targets/?format=json&limit=all.") do |infile|
		options[:infile] = infile
	end
end.parse!


fh = File.read(options[:infile])
json_data = JSON.parse(fh)
#if json_data.has_key?("@graph")
#	json_data = json_data["@graph"]
#end

labels = []
count = 0
json_data.each do |x|
	organism = x["organism"]["scientific_name"]
	if organism != "Homo sapiens"
		next
	end
	names = []
	params = {}
	#dcc_id = x["@id"].split("/").last
	#params[:encode_identifier] = dcc_id
	#gene_name = x["gene_name"]
	#if gene_name.nil?
	#	count += 1
	#	next	
	#end
	puts x["label"]
	#params[:name] = gene_name
#	name = x["gene_name"]
#	if not names.include? name
#		names << name
#	else
#		print(name)
#		break
#	end
	
end

