# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create!(email: "admin@enc.com", password: "password", admin: true)
User.create!(email: "viewer@enc.com",password: "password")

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

#Vendor
#see script in lib called upload_vendors.rb.

HumanDonor.delete_all
HumanDonor.create!([
	{encode_identifier: "ENCDO268AAA", encode_alias:"bernstein:donor of NHEK cells"},
	{encode_identifier: "ENCDO000ABE", encode_alias:"encode:donor of HCT-116"}
	])

Isotype.delete_all
Isotype.create!([
	{ name: "IgA1"},
	{ name: "IgA2"},
	{ name: "IgD"},
	{ name: "IgG"},
	{ name: "IgGκ"},
	{ name: "IgG1"},
	{ name: "IgG1κ"},
	{ name: "IgG1λ"},
	{ name: "IgG2"},
	{ name: "IgG2κ"},
	{ name: "IgG2λ"},
	{ name: "IgG2a"},
	{ name: "IgG2aκ"},
	{ name: "IgG2aλ"},
	{ name: "IgG2b"},
	{ name: "IgG2bκ"},
	{ name: "IgG2bλ"},
	{ name: "IgG3"},
	{ name: "IgG3κ"},
	{ name: "IgG4"},
	{ name: "IgA"},
	{ name: "IgM"},
	{ name: "IgMκ"},
	{ name: "IgE"},
	{ name: "serum"}
])

#HumanGenes
#see script in lib called upload_human_genes.rb

AntibodyPurification.delete_all
AntibodyPurification.create!([
	{name: "Protein A/G" },
	{name: "affinity" },
	{name: "Protein A"},
	{name: "Protein G"},
	{name: "crude"},
	{name: "other"},
	{name: "IEC"},
	{name: "IMAC"},
	{name: "tissue culture supernatant"},
	{name: "antiserum"},
	{name: "IgG fraction"}
])

Organism.delete_all
Organism.create!([
	{name: "avictoria"},
	{name: "bacteriophage-phi-x174"},
	{name: "bacteriophage-t7"},
	{name: "cbrenneri"},
	{name: "cbriggsae"},
	{name: "celegans"},
	{name: "chicken"},
	{name: "cjaponica"},
	{name: "cremanei"},
	{name: "dananassae"},
	{name: "dmelanogaster"},
	{name: "dmojavensis"},
	{name: "dpseudoobscura"},
	{name: "dsimulans"},
	{name: "dvirilis"},
	{name: "dyakuba"},
	{name: "goat" },
	{name: "guineapig" },
	{name: "human" },
	{name: "influenza" },
	{name: "mouse" },
	{name: "rabbit"},
	{name: "rat"   },
	{name: "savidinii" },
	{name: "sheep" },
	{name: "synthetic" }
])

SequencingPlatform.delete_all
SequencingPlatform.create!([
	{name: "Illumina MiSeq"},
	{name: "Illumina HiSeq 2000"},
	{name: "Illumina HiSeq 4000"}
])

ExperimentType.delete_all
ExperimentType.create!([
	{name: "ChIP-Seq"},
	{name: "ATAC-Seq"}
])

ReferenceGenome.delete_all
ReferenceGenome.create!([
	{name: "UCSC hg19", url: "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/"},
	{name: "NCBI GRCh37",url: "http://www.ncbi.nlm.nih.gov/projects/genome/assembly/grc/human"},
	{name: "UCSC hg38", url: "http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/"},
	{name: "NCBI GRCh38", url: "http://www.ncbi.nlm.nih.gov/projects/genome/assembly/grc/human"}
])
