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

admin_user_id = User.find_by!(email: "admin@enc.com").id

BiosampleOntology.delete_all
BiosampleOntology.create!([
	{user_id: admin_user_id, name: "CL", url: "http://www.obofoundry.org/ontology/cl.html"},
	{user_id: admin_user_id, name: "Uberon", url: "http://uberon.github.io/"},
	{user_id: admin_user_id, name: "EFO", url: "http://www.ebi.ac.uk/efo/"}
])

BiosampleTermName.delete_all
BiosampleTermName.create!([
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "GM12878", accession: "EFO_0002784", description: "None provided"},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "CL").id, name: "hepatic stellate cell", accession: "CL:0000632", description: "A cell that is found in the perisinusoidal space of the liver that is capable of multiple roles including storage of retinol, presentation of antigen to T cells (including CD1d-restricted NKT cells), and upon activation, production of extracellular matrix components that can contribute to liver fibrosis."},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "CL").id, name: "mesenchymal stem cell of the bone marrow", accession: "CL:0002540", description: "A mesenchymal stem cell
  that is part of the bone marrow. [database_cross_reference: GOC:tfm]"},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "Uberon").id, name: "liver", accession: "UBERON:0002107", description: "Liver"},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "Uberon").id, name: "heart left ventricle", accession: "UBERON:0002084", description: "A cardiac ventricle that is in the left side of the heart. [database_cross_reference: http://orcid.org/0000-0002-6601-2165]"},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "K562", accession: "EFO_0002067", description: "Human chronic myeloid leukemia in blast crisis established from the pleural effusion of a 53-year-old woman with chronic myeloid leukemia (CML) in blast crisis in 1970; cells can be used as highly sensitive targets in in-vitro natural killer assays; cells produce hemoglobin; cells carry the Philadelphia chromosome with a b3-a2 fusion gene."},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "HEK293", accession: "EFO_0001182", description: "human embryonic kidney cell"},
	{user_id: admin_user_id, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "H1-hESC", accession: "EFO_0003042", description: "H1 human embryonic stem cell line, usually called H1-hESC and on occasion just H1"}
])


LibraryFragmentationMethod.delete_all
LibraryFragmentationMethod.create!([
	{user_id: admin_user_id, name: "chemical (generic)", description: ""},
	{user_id: admin_user_id, name: "chemical (DNaseI)",  description: ""},
	{user_id: admin_user_id, name: "chemical (RNase III)", description: ""},
	{user_id: admin_user_id, name: "chemical (HindIII/DpnII restriction)", description: ""},
	{user_id: admin_user_id, name: "chemical (Tn5 transposase)", description: ""},
	{user_id: admin_user_id, name: "chemical (micrococcal nuclease)", description: ""},
	{user_id: admin_user_id, name: "chemical (Illumina TruSeq)", description: ""},
	{user_id: admin_user_id, name: "chemical (Nextera tagmentation)", description: ""},
	{user_id: admin_user_id, name: "shearing (generic)", description: ""},
	{user_id: admin_user_id, name: "shearing (Covaris generic)", description: ""},
	{user_id: admin_user_id, name: "shearing (Covaris S2)", description: ""},
	{user_id: admin_user_id, name: "sonication (generic)", description: ""},
	{user_id: admin_user_id, name: "sonication (Bioruptor generic)", description: ""},
	{user_id: admin_user_id, name: "sonication (Bioruptor Pico)", description: ""},
	{user_id: admin_user_id, name: "sonication (Bioruptor Plus)", description: ""},
	{user_id: admin_user_id, name: "sonication (Bioruptor Twin)", description: ""},
	{user_id: admin_user_id, name: "sonication (generic microtip)", description: ""},
	{user_id: admin_user_id, name: "sonication (Branson Sonifier 250)", description: ""},
	{user_id: admin_user_id, name: "sonication (Branson Sonifier 450)", description: ""},
	{user_id: admin_user_id, name: "shearing (Covaris LE Series)", description: ""},
	{user_id: admin_user_id, name: "see document", description: ""},
	{user_id: admin_user_id, name: "none", description: ""}
])

NucleicAcidTerm.delete_all
NucleicAcidTerm.create!([
	{user_id: admin_user_id, name: "DNA", accession: "SO:0000352", definition: "An attribute describing a sequence consisting of nucleobases bound to a repeating unit made of a 2-deoxy-D-ribose ring connected to a phosphate backbone."},
	{user_id: admin_user_id, name: "RNA", accession: "SO:0000356", definition: "An attribute describing a sequence consisting of nucleobases bound to a repeating unit made of a D-ribose ring connected to a phosphate backbone."},
	{user_id: admin_user_id, name: "polyadenylated mRNA", accession: "SO:0000871", definition: "An mRNA that is polyadenylated."},
	{user_id: admin_user_id, name: "miRNA", accession: "SO:0000276", definition: "micro RNA"},
	{user_id: admin_user_id, name: "protein", accession: "SO:0000104", definition: "sequence of amino acids linked by peptide bonds which may lack appreciable tertiary structure and may not be liable to irreversible denaturation."}
])

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
	{user_id: admin_user_id, name: "primary cell"},
	{user_id: admin_user_id, name: "immortalized cell line"},
	{user_id: admin_user_id, name: "tissue"},
	{user_id: admin_user_id, name: "in vitro differentiated cells"},
	{user_id: admin_user_id, name: "induced pluripotent stem cell line"},
	{user_id: admin_user_id, name: "whole organisms"},
	{user_id: admin_user_id, name: "stem cell"}
	])

DocumentType.delete_all
DocumentType.create!([
	{user_id: admin_user_id, name: "growth protocol"},
	{user_id: admin_user_id, name: "extraction protocol"},
	{user_id: admin_user_id, name: "certificate of analysis"},
	{user_id: admin_user_id, name: "data QA"},
	{user_id: admin_user_id, name: "differentiation protocol"},
	{user_id: admin_user_id, name: "dedifferentiation protocol"},
	{user_id: admin_user_id, name: "data sheet"},
	{user_id: admin_user_id, name: "treatment protocol"},
	{user_id: admin_user_id, name: "general protocol"},
	{user_id: admin_user_id, name: "excision protocol"},
	{user_id: admin_user_id, name: "transfection protocol"},
	{user_id: admin_user_id, name: "construct image"},
	{user_id: admin_user_id, name: "cell isolation protocol"},
	{user_id: admin_user_id, name: "iPS reprogramming protocol"},
	{user_id: admin_user_id, name: "standards document"},
	{user_id: admin_user_id, name: "strain generation protocol"},
	{user_id: admin_user_id, name: "spike-in concentrations"},
	{user_id: admin_user_id, name: "pipeline protocol"},
	{user_id: admin_user_id, name: "file format specification"},
	{user_id: admin_user_id, name: "high resolution pathology slide image"},
	{user_id: admin_user_id, name: "other"}
	])

Uberon.delete_all
Uberon.create!([
	{user_id: admin_user_id, name: "head", accession: "UBERON_0000033"},
	{user_id: admin_user_id, name: "limb", accession: "UBERON:0002101"},
	{user_id: admin_user_id, name: "saliva-secreting gland", accession: "UBERON:0001044"},
	{user_id: admin_user_id, name: "male accessory sex gland", accession: "UBERON:0010147"},
	{user_id: admin_user_id, name: "testis", accession: "UBERON:0000473"},
	{user_id: admin_user_id, name: "female gonad", accession: "UBERON:0000992"},
	{user_id: admin_user_id, name: "digestive system", accession: "UBERON:0001007"},
	{user_id: admin_user_id, name: "adult maxillary segment", accession: "FBbt:00003016"},
	{user_id: admin_user_id, name: "female reproductive system", accession: "UBERON:0000474"},
	{user_id: admin_user_id, name: "male reproductive system", accession: "UBERON:0000079"}
	])

#Vendor
#see script in lib called upload_vendors.rb.

Donor.delete_all
Donor.create!([
	{user_id: admin_user_id, encode_identifier: "ENCDO268AAA", name:"bernstein:donor of NHEK cells"},
	{user_id: admin_user_id, encode_identifier: "ENCDO000ABE", name:"encode:donor of HCT-116"},
	{user_id: admin_user_id, encode_identifier: "ENCDO000ABF", name: "encode:donor of HEK293"},
	{user_id: admin_user_id, encode_identifier: "ENCDO000AAK", name: "encode:donor of GM12878"
	])

Isotype.delete_all
Isotype.create!([
	{user_id: admin_user_id, name: "IgA1"},
	{user_id: admin_user_id, name: "IgA2"},
	{user_id: admin_user_id, name: "IgD"},
	{user_id: admin_user_id, name: "IgG"},
	{user_id: admin_user_id, name: "IgGκ"},
	{user_id: admin_user_id, name: "IgG1"},
	{user_id: admin_user_id, name: "IgG1κ"},
	{user_id: admin_user_id, name: "IgG1λ"},
	{user_id: admin_user_id, name: "IgG2"},
	{user_id: admin_user_id, name: "IgG2κ"},
	{user_id: admin_user_id, name: "IgG2λ"},
	{user_id: admin_user_id, name: "IgG2a"},
	{user_id: admin_user_id, name: "IgG2aκ"},
	{user_id: admin_user_id, name: "IgG2aλ"},
	{user_id: admin_user_id, name: "IgG2b"},
	{user_id: admin_user_id, name: "IgG2bκ"},
	{user_id: admin_user_id, name: "IgG2bλ"},
	{user_id: admin_user_id, name: "IgG3"},
	{user_id: admin_user_id, name: "IgG3κ"},
	{user_id: admin_user_id, name: "IgG4"},
	{user_id: admin_user_id, name: "IgA"},
	{user_id: admin_user_id, name: "IgM"},
	{user_id: admin_user_id, name: "IgMκ"},
	{user_id: admin_user_id, name: "IgE"},
	{user_id: admin_user_id, name: "serum"}
])

#HumanGenes
#see script in lib called upload_human_genes.rb

AntibodyPurification.delete_all
AntibodyPurification.create!([
	{user_id: admin_user_id, name: "Protein A/G"},
	{user_id: admin_user_id, name: "affinity" },
	{user_id: admin_user_id, name: "Protein A"},
	{user_id: admin_user_id, name: "Protein G"},
	{user_id: admin_user_id, name: "crude"},
	{user_id: admin_user_id, name: "other"},
	{user_id: admin_user_id, name: "IEC"},
	{user_id: admin_user_id, name: "IMAC"},
	{user_id: admin_user_id, name: "tissue culture supernatant"},
	{user_id: admin_user_id, name: "antiserum"},
	{user_id: admin_user_id, name: "IgG fraction"}
])

Organism.delete_all
Organism.create!([
	{user_id: admin_user_id, name: "avictoria"},
	{user_id: admin_user_id, name: "bacteriophage-phi-x174"},
	{user_id: admin_user_id, name: "bacteriophage-t7"},
	{user_id: admin_user_id, name: "cbrenneri"},
	{user_id: admin_user_id, name: "cbriggsae"},
	{user_id: admin_user_id, name: "celegans"},
	{user_id: admin_user_id, name: "chicken"},
	{user_id: admin_user_id, name: "cjaponica"},
	{user_id: admin_user_id, name: "cremanei"},
	{user_id: admin_user_id, name: "dananassae"},
	{user_id: admin_user_id, name: "dmelanogaster"},
	{user_id: admin_user_id, name: "dmojavensis"},
	{user_id: admin_user_id, name: "dpseudoobscura"},
	{user_id: admin_user_id, name: "dsimulans"},
	{user_id: admin_user_id, name: "dvirilis"},
	{user_id: admin_user_id, name: "dyakuba"},
	{user_id: admin_user_id, name: "goat" },
	{user_id: admin_user_id, name: "guineapig" },
	{user_id: admin_user_id, name: "human" },
	{user_id: admin_user_id, name: "influenza" },
	{user_id: admin_user_id, name: "mouse" },
	{user_id: admin_user_id, name: "rabbit"},
	{user_id: admin_user_id, name: "rat"   },
	{user_id: admin_user_id, name: "savidinii" },
	{user_id: admin_user_id, name: "sheep" },
	{user_id: admin_user_id, name: "synthetic" }
])

SequencingPlatform.delete_all
SequencingPlatform.create!([
	{user_id: admin_user_id, name: "Illumina MiSeq"},
	{user_id: admin_user_id, name: "Illumina HiSeq 2000"},
	{user_id: admin_user_id, name: "Illumina HiSeq 4000"}
])

ExperimentType.delete_all
ExperimentType.create!([
	{user_id: admin_user_id, name: "ChIP-Seq"},
	{user_id: admin_user_id, name: "ATAC-Seq"}
])

ReferenceGenome.delete_all
ReferenceGenome.create!([
	{user_id: admin_user_id, name: "UCSC hg19", url: "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/"},
	{user_id: admin_user_id, name: "NCBI GRCh37",url: "http://www.ncbi.nlm.nih.gov/projects/genome/assembly/grc/human"},
	{user_id: admin_user_id, name: "UCSC hg38", url: "http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/"},
	{user_id: admin_user_id, name: "NCBI GRCh38", url: "http://www.ncbi.nlm.nih.gov/projects/genome/assembly/grc/human"}
])

Target.delete_all
Target.create!([
{user_id: admin_user_id, name: "RELB-human", encode_identifier: "4c8ef6d7-d7e9-4af5-9b8b-4e44450b5c3c"}
])

Antibody.delete_all
Antibody.create!([
{user_id: admin_user_id, name: "ENCAB140SNC", organism_id: Organism.find_by!(name: "human").id, vendor_product_identifier: "A302-183A", vendor_id: Vendor.find_by!(encode_identifier: "bethyl-labs").id, clonality: "polyclonal", target_id: Target.find_by!(encode_identifier: "RELB-human").id, antibody_purifications: [AntibodyPurification.find_by!(name: "affinity")], lot_identifier: 1},
{user_id: admin_user_id, name: "ENCAB830JLB", organism_id: Organism.find_by!(name: "human").id, vendor_product_identifier: "07-729", vendor_id: Vendor.find_by!(encode_identifier: "millipore").id, clonality: "polyclonal", target_id: Target.find_by!(encode_identifier: "CTCF-human").id, antibody_purifications: [], lot_identifier: 2599305}
])

Biosample.delete_all
Biosample.create!([
	{user_id: admin_user_id, biosample_term_name_id: BiosampleTermName.find_by!(name: "HEK293").id, name: "ENCBS826GBM", encid: "ENCBS826GBM", description: "HEK293 cell line stably expressing N-terminal tagged eGFP-RBAK under the control of a CMV promoter.", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of HEK293").id, lot_identifier: "GR158277-1", vendor_id: Vendor.find_by!(encode_identifier: "dgrc").id, vendor_product_identifier: "WH0008531M2", documents: [Document.first]},

{user_id: admin_user_id, biosample_term_name_id: BiosampleTermName.find_by!(name: "HEK293").id, name: "ENCBS758JEW", encid: "ENCBS758JEW", description: "HEK293 cell line stably expressing N-terminal tagged eGFP-RBAK under the control of a CMV promoter.", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of HEK293").id, lot_identifier: "GR158277-1", vendor_id: Vendor.find_by!(encode_identifier: "dgrc").id, vendor_product_identifier: "WH0008531M2", documents: [Document.first]},

{user_id: admin_user_id, biosample_term_name_id: BiosampleTermName.find_by!(name: "GM12878").id, name: "ENCBS389LEA", encid: "ENCBS389LEA", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of GM12878").id, vendor_id: Vendor.find_by!(encode_identifier: "coriell").id, vendor_product_identifier: "GM12878", documents: [Document.second]},

{user_id: admin_user_id, biosample_term_name_id: BiosampleTermName.find_by!(name: "GM12878").id, name: "ENCBS488GLI", encid: "ENCBS488GLI", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of GM12878").id, vendor_id: Vendor.find_by!(encode_identifier: "coriell").id, vendor_product_identifier: "GM12878", documents: [Document.second],culture_harvest_date: "2014-06-05"}
])

Library.delete_all
Library.create!([
	{user_id: admin_user_id, name: "lib1", barcode: "ATCCGTA", nucleic_acid_term_id: NucleicAcidTerm.find_by!(name: "DNA").id, biosample_id: Biosample.find_by!(name: "ENCBS488GLI").id, size_range: "450-650", documents: [Document.second],strand_specific: false, antibody_id: Antibody.find_by!(name: "ENCAB140SNC").id},

	{user_id: admin_user_id, name: "lib2", barcode: "GATGGAC", nucleic_acid_term_id: NucleicAcidTerm.find_by!(name: "DNA").id, biosample_id: Biosample.find_by!(name: "ENCBS389LEA").id, size_range: "450-650", documents: [Document.second],strand_specific: false, antibody_id: Antibody.find_by!(name: "ENCAB140SNC").id}
])
	
