# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.delete_all
#User.create!(email: "admin@enc.com", password: "password", admin: true)
#User.create!(email: "viewer@enc.com",password: "password")

admin_user_id = User.find_by(email: "admin@enc.com").id

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

Donor.delete_all
Donor.create!([
	{user_id: admin_user_id, encode_identifier: "ENCDO268AAA", encode_alias:"bernstein:donor of NHEK cells"},
	{user_id: admin_user_id, encode_identifier: "ENCDO000ABE", encode_alias:"encode:donor of HCT-116"},
	{user_id: admin_user_id, encode_identifier: "ENCDO000ABF", encode_alias: "encode:donor of HEK293"},
	{user_id: admin_user_id, encode_identifier: "ENCDO000AAK", encode_alias: "encode:donor of GM12878"
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
	{name: "Protein A/G", user_id: admin_user_id},
	{name: "affinity" , user_id: admin_user_id },
	{name: "Protein A", user_id: admin_user_id },
	{name: "Protein G", user_id: admin_user_id },
	{name: "crude", user_id: admin_user_id },
	{name: "other", user_id: admin_user_id },
	{name: "IEC", user_id: admin_user_id },
	{name: "IMAC", user_id: admin_user_id },
	{name: "tissue culture supernatant", user_id: admin_user_id },
	{name: "antiserum", user_id: admin_user_id },
	{name: "IgG fraction", user_id: admin_user_id }
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

HumanTarget.delete_all
HumanTarget.create!([
{name: "RELB-human", user_id: admin_user_id, encode_identifier: "4c8ef6d7-d7e9-4af5-9b8b-4e44450b5c3c"}
])

Antibody.delete_all
Antibody.create!([
{name: "ENCAB140SNC", user_id: admin_user_id, organism_id: Organism.find_by(name: "human").id, vendor_product_identifier: "A302-183A", vendor_id: Vendor.find_by(name: "bethyl-labs").id, clonality: "polyclonal", human_target_id: HumanTarget.find_by(name: "RELB-human").id, antibody_purifications: [AntibodyPurification.find_by(name: "affinity")], lot_identifier: 1}
])

Biosample.delete_all
Biosample.create!([
	{name: "ENCBS826GBM", user_id: admin_user_id, encid: "ENCBS826GBM", escription: "HEK293 cell line stably expressing N-terminal tagged eGFP-RBAK under the control of a CMV promoter.", biosample_type_id: BiosampleType.find_by(name: "immortalized cell line").id, donor_id: Donor.find_by(encode_alias: "encode:donor of HEK293").id, ontology_term_accession: "EFO:0001182", ontology_term_name: "HEK293", lot_identifier: "GR158277-1", vendor_id: Vendor.find_by(name: "timothy-hughes").id, vendor_product_identifier: "WH0008531M2", documents: [Document.first]},

{name: "ENCBS758JEW", user_id: admin_user_id, encid: "ENCBS758JEW", description: "HEK293 cell line stably expressing N-terminal tagged eGFP-RBAK under the control of a CMV promoter.", biosample_type_id: BiosampleType.find_by(name: "immortalized cell line").id, donor_id: Donor.find_by(encode_alias: "encode:donor of HEK293").id, ontology_term_accession: "EFO:0001182", ontology_term_name: "HEK293", lot_identifier: "GR158277-1", vendor_id: Vendor.find_by(name: "timothy-hughes").id, vendor_product_identifier: "WH0008531M2", documents: [Document.first]},

{name: "ENCBS389LEA", user_id: admin_user_id, encid: "ENCBS389LEA", biosample_type_id: BiosampleType.find_by(name: "immortalized cell line").id, donor_id: Donor.find_by(encode_alias: "encode:donor of GM12878").id, ontology_term_accession: "EFO:0002784", ontology_term_name: "GM12878", vendor_id: Vendor.find_by(name: "coriell").id, vendor_product_identifier: "GM12878", documents: [Document.second]},

{name: "ENCBS488GLI", user_id: admin_user_id, encid: "ENCBS488GLI", biosample_type_id: BiosampleType.find_by(name: "immortalized cell line").id, donor_id: Donor.find_by(encode_alias: "encode:donor of GM12878").id, ontology_term_accession: "EFO:0002784", ontology_term_name: "GM12878", vendor_id: Vendor.find_by(name: "coriell").id, vendor_product_identifier: "GM12878", documents: [Document.second],culture_harvest_date: "2014-06-05"}
])

Library.delete_all
Library.create!([
	{name: "ENCLB709JYF", user_id: admin_user_id, nucleic_acid_term_id: NucleicAcidTerm.find_by(name: "DNA").id, biosample_id: Biosample.find_by(name: "ENCBS488GLI").id, size_range: "450-650", documents: [Document.second],strand_specific: false, antibody_id: Antibody.find_by(name: "ENCAB140SNC").id}
])
	
