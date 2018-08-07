#!/usr/bin/env /Users/nathankw/repos/pulsar_lims/bin/rails runner

#require "json" #not needed since I added this to the Gemfile and RAILS already requires all gems when using rails runner.
require "optparse"
require "json"

SPECIES="Homo sapiens"

options = {}
OptionParser.new do |opts|
  opts.on("--infile [INFILE]",help="A search URL to indicate which biosamples to import, i.e. 'https://www.encodeproject.org/search/?type=Biosample&lab.title=Michael+Snyder%2C+Stanford&award.rfa=ENCODE4&biosample_type=tissue'.") do |infile|
    options[:infile] = infile
  end
end.parse!

admin = User.find_by(email: "admin@enc.com")

fh = File.read(options[:infile])
json_data = JSON.parse(fh)

#if json_data.has_key?("@graph")
#  json_data = json_data["@graph"]
#end

total = 0
created=0
json_data.each do |rec|
  total += 1
  organism = rec["organism"]["scientific_name"]
  if organism != SPECIES
    next
  end
  label = rec["label"]
  upstream = rec["@id"].split("/").last
  params = {}
  params[:user_id] = admin.id
  params[:name] = label
  params[:upstream_identifier] = upstream 
  xrefs = rec["dbxref"]                                                                                
  xrefs.each do |ref|                                                                                  
    prefix, ref = ref.split(":")                                                                       
    if prefix == "ENSEMBL"                                                                             
      params[:ensembl] = ref                                                                           
    elsif prefix == "UniProtKB"                                                                        
      params[:uniprotkb] = ref                                                                         
    elsif prefix == "RefSeq"                                                                           
      params[:refseq] = ref                                                                            
    end                                                                                                
  end
  target = Target.find_by(name: label)
  #if target.present?                                                                                   
  #  target.update(params)                                                                              
  #else
    #Using the label since it's unique and all entries have it. The                                 
    #Target.create!(params)                                                                          
  # end
  if target.blank?
    p "Creating target #{label}"
    Target.create!(params)
    created += 1
  end 
end
puts "Total: #{total}"
puts "Created: #{created}"

