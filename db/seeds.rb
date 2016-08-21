# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SequenceOntologyTerm.delete_all
SequenceOntologyTerm.create!(name: "DNA",
	accession: "SO:0000352",
	definition: %{ An attribute describing a sequence consisting of nucleobases bound to a repeating unit made of a 
			2-deoxy-D-ribose ring connected to a phosphate backbone.},
	)

SequenceOntologyTerm.create!(name: "RNA",
	accession: "SO:0000356",
	definition: %{An attribute describing a sequence consisting of nucleobases bound to a repeating unit made of a 
		D-ribose ring connected to a phosphate backbone.},
	)

SequenceOntologyTerm.create!(name: "polyadenylated mRNA",
	accession: 	"SO:0000871",
	definition: "An mRNA that is polyadenylated."
	)

SequenceOntologyTerm.create!(name: "miRNA",
	accession: "SO:0000276",
	definition: "micro RNA"
	)

SequenceOntologyTerm.create!(name: "protein",
	accession: "SO:0000104",
	definition: %{ sequence of amino acids linked by peptide bonds which may lack appreciable tertiary structure 
		and may not be liable to irreversible denaturation.}
	)

BiosampleType.delete_all
BiosampleType.create!([
	{name: "primary cell"},
	{name: "immortalized cell line"},
	{name: "tissue"},
	{name: "in vitro differentiated cells"},
	{name: "induced pluripotent stem cell line"},
	{name: "whole organisms"},
	{name: "stem cell"}
	])

DocumentType.delete_all
DocumentType.create!([
	{name: "growth protocol"},
	{name: "extraction protocol"},
	{name: "certificate of analysis"},
	{name: "data QA"},
	{name: "differentiation protocol"},
	{name: "dedifferentiation protocol"},
	{name: "data sheet"},
	{name: "treatment protocol"},
	{name: "general protocol"},
	{name: "excision protocol"},
	{name: "transfection protocol"},
	{name: "construct image"},
	{name: "cell isolation protocol"},
	{name: "iPS reprogramming protocol"},
	{name: "standards document"},
	{name: "strain generation protocol"},
	{name: "spike-in concentrations"},
	{name: "pipeline protocol"},
	{name: "file format specification"},
	{name: "high resolution pathology slide image"},
	{name: "other"}
	])

Uberon.delete_all
Uberon.create!([
	{name: "head", accession: "UBERON_0000033"},
	{name: "limb", accession: "UBERON:0002101"},
	{name: "saliva-secreting gland", accession: "UBERON:0001044"},
	{name: "male accessory sex gland", accession: "UBERON:0010147"},
	{name: "testis", accession: "UBERON:0000473"},
	{name: "female gonad", accession: "UBERON:0000992"},
	{name: "digestive system", accession: "UBERON:0001007"},
	{name: "adult maxillary segment", accession: "FBbt:00003016"},
	{name: "female reproductive system", accession: "UBERON:0000474"},
	{name: "male reproductive system", accession: "UBERON:0000079"}
	])
