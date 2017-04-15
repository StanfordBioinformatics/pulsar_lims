# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create!(email: "admin@enc.com", password: "password", role: User::ADMIN_ROLE)
User.create!(email: "viewer@enc.com",password: "password")

admin = User.find_by!(email: "admin@enc.com").id

DocumentType.delete_all
DocumentType.create!([
	{user_id: admin, name: "growth protocol"},
	{user_id: admin, name: "extraction protocol"},
	{user_id: admin, name: "certificate of analysis"},
	{user_id: admin, name: "data QA"},
	{user_id: admin, name: "differentiation protocol"},
	{user_id: admin, name: "dedifferentiation protocol"},
	{user_id: admin, name: "data sheet"},
	{user_id: admin, name: "treatment protocol"},
	{user_id: admin, name: "general protocol"},
	{user_id: admin, name: "excision protocol"},
	{user_id: admin, name: "transfection protocol"},
	{user_id: admin, name: "construct image"},
	{user_id: admin, name: "cell isolation protocol"},
	{user_id: admin, name: "iPS reprogramming protocol"},
	{user_id: admin, name: "standards document"},
	{user_id: admin, name: "strain generation protocol"},
	{user_id: admin, name: "spike-in concentrations"},
	{user_id: admin, name: "pipeline protocol"},
	{user_id: admin, name: "file format specification"},
	{user_id: admin, name: "high resolution pathology slide image"},
	{user_id: admin, name: "other"}
	])

Vendor.delete_all
Vendor.create!([
	{user_id: admin, name: "Abcam", encode_identifier: "abcam", url: "http://www.abcam.com"},
	{user_id: admin, name: "Active Motif", encode_identifier: "active-motif", url: "http://www.activemotif.com"},
	{user_id: admin, name: "Agilent", encode_identifier: "agilent", url: "http://www.home.agilent.com"},
	{user_id: admin, name: "Bethyl Labs", encode_identifier: "bethyl-labs", url: "http://www.bethyl.com"},
	{user_id: admin, name: "Coriell", encode_identifier: "coriell", url: "http://www.coriell.org"},
	{user_id: admin, name: "Illumina", encode_identifier: "illumina", url: "http://www.illumina.com"},
	{user_id: admin, name: "New England BioLabs", encode_identifier: "", url: "https://www.neb.com"},
	{user_id: admin, name: "Sigma", encode_identifier: "sigma", url: "http://www.sigmaaldrich.com"},
	{user_id: admin, name: "Thermo Fisher", encode_identifier: "thermo-fisher", url: "http://www.thermofisher.com/global/en/home.asp"},
	{user_id: admin, name: "Millipore", encode_identifier: "millipore", url: "http://www.emdmillipore.com"}
])

BiosampleOntology.delete_all
BiosampleOntology.create!([
	{user_id: admin, name: "CL", url: "http://www.obofoundry.org/ontology/cl.html"},
	{user_id: admin, name: "Uberon", url: "http://uberon.github.io/"},
	{user_id: admin, name: "EFO", url: "http://www.ebi.ac.uk/efo/"}
])

BiosampleTermName.delete_all
BiosampleTermName.create!([
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "GM12878", accession: "EFO_0002784", description: "None provided"},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "CL").id, name: "hepatic stellate cell", accession: "CL:0000632", description: "A cell that is found in the perisinusoidal space of the liver that is capable of multiple roles including storage of retinol, presentation of antigen to T cells (including CD1d-restricted NKT cells), and upon activation, production of extracellular matrix components that can contribute to liver fibrosis."},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "CL").id, name: "mesenchymal stem cell of the bone marrow", accession: "CL:0002540", description: "A mesenchymal stem cell that is part of the bone marrow. [database_cross_reference: GOC:tfm]"},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "Uberon").id, name: "liver", accession: "UBERON:0002107", description: "Liver"},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "Uberon").id, name: "heart left ventricle", accession: "UBERON:0002084", description: "A cardiac ventricle that is in the left side of the heart. [database_cross_reference: http://orcid.org/0000-0002-6601-2165]"},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "K562", accession: "EFO_0002067", description: "Human chronic myeloid leukemia in blast crisis established from the pleural effusion of a 53-year-old woman with chronic myeloid leukemia (CML) in blast crisis in 1970; cells can be used as highly sensitive targets in in-vitro natural killer assays; cells produce hemoglobin; cells carry the Philadelphia chromosome with a b3-a2 fusion gene."},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "HEK293", accession: "EFO_0001182", description: "human embryonic kidney cell"},
	{user_id: admin, biosample_ontology_id: BiosampleOntology.find_by!(name: "EFO").id, name: "H1-hESC", accession: "EFO_0003042", description: "H1 human embryonic stem cell line, usually called H1-hESC and on occasion just H1"}
])

ConstructTag.delete_all
ConstructTag.create!([
	{user_id: admin, name: "eGFP"},
	{user_id: admin, name: "V5"},
	{user_id: admin, name: "HA"},
	{user_id: admin, name: "ER"},
	{user_id: admin, name: "3xFLAG"},
	{user_id: admin, name: "DsRed"},
	{user_id: admin, name: "TRE"},
	{user_id: admin, name: "T2A"},
	{user_id: admin, name: "YFP"},
	{user_id: admin, name: "FLAG"},
])

illumina_truseq_dna_pcr_free = Rails.root.join("lib","seeds","truseq-dna-pcr-free-library-prep-guide-15036187-d.pdf")
illumina_adapter_letter = Rails.root.join("lib","seeds","illumina-adapter-sequences_1000000002694-01.pdf")
Document.delete_all
Document.create!([
	{user_id: admin, name: File.basename(illumina_truseq_dna_pcr_free), content_type: "application/pdf", 
		data: File.open(illumina_truseq_dna_pcr_free,"rb").read(), is_protocol: false, 
		description: "Illumina reference guide.",
		document_type_id: DocumentType.find_by(name: "general protocol").id},

	{user_id: admin, name: File.basename(illumina_adapter_letter), content_type: "application/pdf", 
		data: File.open(illumina_adapter_letter,"rb").read(), is_protocol: false, 
		description: "Illumina barcodes for various library prep kits.",
		document_type_id: DocumentType.find_by(name: "general protocol").id}
])

SequencingLibraryPrepKit.delete_all
SequencingLibraryPrepKit.create!([
	{user_id: admin, name: "Illumina TruSeq HT Kits", documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")], vendor_id: Vendor.find_by(name: "Illumina").id, description: "Includes TruSeq DNA PCR-Free HT, TruSeq Nano HT, TruSeq Stranded mRNA HT, and TruSeq Total RNA HT"},
	{user_id: admin, name: "Illumina TruSeq LT Kits", documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")] ,vendor_id: Vendor.find_by(name: "Illumina").id, description: "Includes TruSeq DNA PCR-Free LT, TruSeq Nano DNA LT, TruSeq DNA v1/v2/LT (obsolete), TruSeq RNA v1/v2/LT, TruSeq Stranded mRNA LT, TruSeq Stranded Total RNA LT, TruSeq RNA Access, and TruSeq ChIP"},
	{user_id: admin, name: "Illumina Nextera Kits", documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")] ,vendor_id: Vendor.find_by(name: "Illumina").id, description: "Includes Nextera DNA, Nextera XT, Nextera Enrichment (obsolete), and Nextera Rapid Capture. Does not include Nextera XT Index Kit v2."},
	{user_id: admin, name: "NEBNext Multiplex Oligos for Illumina (Dual Index Primers Set 1)", documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")] ,vendor_id: Vendor.find_by(name: "New England BioLabs").id, vendor_product_identifier: "E7600S", description: "Contains the adaptor and index primers that are ideally suited for multiplex sample preparation for next-generation sequencing on the Illumina platform. Designed for use with specific NEBNext Kits, see https://www.neb.com/~/media/Catalog/All-Products/E7CFA11A57424D299FAA2AF513787BBE/Datacards%20or%20Manuals/manualE7600.pdf."}
])

truseq_ht_kits_id = SequencingLibraryPrepKit.find_by!(name: "Illumina TruSeq HT Kits").id
truseq_lt_kits_id = SequencingLibraryPrepKit.find_by!(name: "Illumina TruSeq LT Kits").id
nextera_kits_id = SequencingLibraryPrepKit.find_by!(name: "Illumina Nextera Kits").id
nebnext_duel_set1_id = SequencingLibraryPrepKit.find_by!(name: "NEBNext Multiplex Oligos for Illumina (Dual Index Primers Set 1)").id
Barcode.delete_all
Barcode.create!([
{user_id: admin, name: "D701", sequence: "ATTACTCG", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D702", sequence: "TCCGGAGA", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D703", sequence: "CGCTCATT", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D704", sequence: "GAGATTCC", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D705", sequence: "ATTCAGAA", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D706", sequence: "GAATTCGT", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D707", sequence: "CTGAAGCT", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D708", sequence: "TAATGCGC", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D709", sequence: "CGGCTATG", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D710", sequence: "TCCGCGAA", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D711", sequence: "TCTCGCGC", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D712", sequence: "AGCGATAG", index_number: 1, sequencing_library_prep_kit_id: truseq_ht_kits_id},
{user_id: admin, name: "D501", sequence: "TATAGCCT", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D502", sequence: "ATAGAGGC", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D503", sequence: "CCTATCCT", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D504", sequence: "GGCTCTGA", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D505", sequence: "AGGCGAAG", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D506", sequence: "TAATCTTA", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D507", sequence: "CAGGACGT", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id}, 
{user_id: admin, name: "D508", sequence: "GTACTGAC", index_number: 2, sequencing_library_prep_kit_id: truseq_ht_kits_id},

{user_id: admin, name: "AD001", sequence: "ATCACG", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD002", sequence: "CGATGT", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD003", sequence: "TTAGGC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD004", sequence: "TGACCA", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD005", sequence: "ACAGTG", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD006", sequence: "GCCAAT", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD007", sequence: "CAGATC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD008", sequence: "ACTTGA", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD009", sequence: "GATCAG", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD010", sequence: "TAGCTT", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD011", sequence: "GGCTAC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD012", sequence: "CTTGTA", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD013", sequence: "AGTCAA", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD014", sequence: "AGTTCC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD015", sequence: "ATGTCA", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD016", sequence: "CCGTCC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD018", sequence: "GTCCGC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD019", sequence: "GTGAAA", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD020", sequence: "GTGGCC", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD021", sequence: "GTTTCG", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD022", sequence: "CGTACG", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD023", sequence: "GAGTGG", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD025", sequence: "ACTGAT", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},
{user_id: admin, name: "AD027", sequence: "ATTCCT", index_number: 1, sequencing_library_prep_kit_id: truseq_lt_kits_id},

{user_id: admin, name: "N701", sequence: "TAAGGCGA", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N702", sequence: "CGTACTAG", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N703", sequence: "AGGCAGAA", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N704", sequence: "TCCTGAGC", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N705", sequence: "GGACTCCT", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N706", sequence: "TAGGCATG", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N707", sequence: "CTCTCTAC", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N708", sequence: "CAGAGAGG", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N709", sequence: "GCTACGCT", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N710", sequence: "CGAGGCTG", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N711", sequence: "AAGAGGCA", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N712", sequence: "GTAGAGGA", index_number: 1, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N501", sequence: "TAGATCGC", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N502", sequence: "CTCTCTAT", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N503", sequence: "TATCCTCT", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N504", sequence: "AGAGTAGA", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N505", sequence: "GTAAGGAG", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N506", sequence: "ACTGCATA", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N507", sequence: "AAGGAGTA", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N508", sequence: "CTAAGCCT", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},
{user_id: admin, name: "N517", sequence: "GCGTAAGA", index_number: 2, sequencing_library_prep_kit_id: nextera_kits_id},

{user_id: admin, name: "i701", sequence: "ATTACTCG", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i702", sequence: "TCCGGAGA", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i703", sequence: "CGCTCATT", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i704", sequence: "GAGATTCC", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i705", sequence: "ATTCAGAA", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i706", sequence: "GAATTCGT", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i707", sequence: "CTGAAGCT", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i708", sequence: "TAATGCGC", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i709", sequence: "CGGCTATG", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i710", sequence: "TCCGCGAA", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i711", sequence: "TCTCGCGC", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i712", sequence: "AGCGATAG", index_number: 1, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i501", sequence: "TATAGCCT", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i502", sequence: "ATAGAGGC", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i503", sequence: "CCTATCCT", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i504", sequence: "GGCTCTGA", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i505", sequence: "AGGCGAAG", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i506", sequence: "TAATCTTA", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i507", sequence: "CAGGACGT", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
{user_id: admin, name: "i508", sequence: "GTACTGAC", index_number: 2, sequencing_library_prep_kit_id: nebnext_duel_set1_id},
])

LibraryFragmentationMethod.delete_all
LibraryFragmentationMethod.create!([
	{user_id: admin, name: "chemical (generic)", description: ""},
	{user_id: admin, name: "chemical (DNaseI)",  description: ""},
	{user_id: admin, name: "chemical (RNase III)", description: ""},
	{user_id: admin, name: "chemical (HindIII/DpnII restriction)", description: ""},
	{user_id: admin, name: "chemical (Tn5 transposase)", description: ""},
	{user_id: admin, name: "chemical (micrococcal nuclease)", description: ""},
	{user_id: admin, name: "chemical (Illumina TruSeq)", description: ""},
	{user_id: admin, name: "chemical (Nextera tagmentation)", description: ""},
	{user_id: admin, name: "shearing (generic)", description: ""},
	{user_id: admin, name: "shearing (Covaris generic)", description: ""},
	{user_id: admin, name: "shearing (Covaris S2)", description: ""},
	{user_id: admin, name: "sonication (generic)", description: ""},
	{user_id: admin, name: "sonication (Bioruptor generic)", description: ""},
	{user_id: admin, name: "sonication (Bioruptor Pico)", description: ""},
	{user_id: admin, name: "sonication (Bioruptor Plus)", description: ""},
	{user_id: admin, name: "sonication (Bioruptor Twin)", description: ""},
	{user_id: admin, name: "sonication (generic microtip)", description: ""},
	{user_id: admin, name: "sonication (Branson Sonifier 250)", description: ""},
	{user_id: admin, name: "sonication (Branson Sonifier 450)", description: ""},
	{user_id: admin, name: "shearing (Covaris LE Series)", description: ""},
	{user_id: admin, name: "see document", description: ""},
	{user_id: admin, name: "none", description: ""}
])

NucleicAcidTerm.delete_all
NucleicAcidTerm.create!([
	{user_id: admin, name: "DNA", accession: "SO:0000352", definition: "An attribute describing a sequence consisting of nucleobases bound to a repeating unit made of a 2-deoxy-D-ribose ring connected to a phosphate backbone."},
	{user_id: admin, name: "RNA", accession: "SO:0000356", definition: "An attribute describing a sequence consisting of nucleobases bound to a repeating unit made of a D-ribose ring connected to a phosphate backbone."},
	{user_id: admin, name: "polyadenylated mRNA", accession: "SO:0000871", definition: "An mRNA that is polyadenylated."},
	{user_id: admin, name: "miRNA", accession: "SO:0000276", definition: "micro RNA"},
	{user_id: admin, name: "protein", accession: "SO:0000104", definition: "sequence of amino acids linked by peptide bonds which may lack appreciable tertiary structure and may not be liable to irreversible denaturation."}
])

BiosampleType.delete_all
BiosampleType.create!([
	{user_id: admin, name: "primary cell"},
	{user_id: admin, name: "immortalized cell line"},
	{user_id: admin, name: "tissue"},
	{user_id: admin, name: "in vitro differentiated cells"},
	{user_id: admin, name: "induced pluripotent stem cell line"},
	{user_id: admin, name: "whole organisms"},
	{user_id: admin, name: "stem cell"}
	])

#Vendor
#see script in lib called upload_vendors.rb.

Donor.delete_all
Donor.create!([
	{user_id: admin, encode_identifier: "ENCDO268AAA", name:"bernstein:donor of NHEK cells"},
	{user_id: admin, encode_identifier: "ENCDO000ABE", name:"encode:donor of HCT-116"},
	{user_id: admin, encode_identifier: "ENCDO000ABF", name: "encode:donor of HEK293"},
	{user_id: admin, encode_identifier: "ENCDO000AAK", name: "encode:donor of GM12878"}
])

Isotype.delete_all
Isotype.create!([
	{user_id: admin, name: "IgA1"},
	{user_id: admin, name: "IgA2"},
	{user_id: admin, name: "IgD"},
	{user_id: admin, name: "IgG"},
	{user_id: admin, name: "IgGκ"},
	{user_id: admin, name: "IgG1"},
	{user_id: admin, name: "IgG1κ"},
	{user_id: admin, name: "IgG1λ"},
	{user_id: admin, name: "IgG2"},
	{user_id: admin, name: "IgG2κ"},
	{user_id: admin, name: "IgG2λ"},
	{user_id: admin, name: "IgG2a"},
	{user_id: admin, name: "IgG2aκ"},
	{user_id: admin, name: "IgG2aλ"},
	{user_id: admin, name: "IgG2b"},
	{user_id: admin, name: "IgG2bκ"},
	{user_id: admin, name: "IgG2bλ"},
	{user_id: admin, name: "IgG3"},
	{user_id: admin, name: "IgG3κ"},
	{user_id: admin, name: "IgG4"},
	{user_id: admin, name: "IgA"},
	{user_id: admin, name: "IgM"},
	{user_id: admin, name: "IgMκ"},
	{user_id: admin, name: "IgE"},
	{user_id: admin, name: "serum"}
])

#HumanGenes
#see script in lib called upload_human_genes.rb

AntibodyPurification.delete_all
AntibodyPurification.create!([
	{user_id: admin, name: "Protein A/G"},
	{user_id: admin, name: "affinity" },
	{user_id: admin, name: "Protein A"},
	{user_id: admin, name: "Protein G"},
	{user_id: admin, name: "crude"},
	{user_id: admin, name: "other"},
	{user_id: admin, name: "IEC"},
	{user_id: admin, name: "IMAC"},
	{user_id: admin, name: "tissue culture supernatant"},
	{user_id: admin, name: "antiserum"},
	{user_id: admin, name: "IgG fraction"}
])

Organism.delete_all
Organism.create!([
	{user_id: admin, name: "avictoria"},
	{user_id: admin, name: "bacteriophage-phi-x174"},
	{user_id: admin, name: "bacteriophage-t7"},
	{user_id: admin, name: "cbrenneri"},
	{user_id: admin, name: "cbriggsae"},
	{user_id: admin, name: "celegans"},
	{user_id: admin, name: "chicken"},
	{user_id: admin, name: "cjaponica"},
	{user_id: admin, name: "cremanei"},
	{user_id: admin, name: "dananassae"},
	{user_id: admin, name: "dmelanogaster"},
	{user_id: admin, name: "dmojavensis"},
	{user_id: admin, name: "dpseudoobscura"},
	{user_id: admin, name: "dsimulans"},
	{user_id: admin, name: "dvirilis"},
	{user_id: admin, name: "dyakuba"},
	{user_id: admin, name: "goat" },
	{user_id: admin, name: "guineapig" },
	{user_id: admin, name: "human" },
	{user_id: admin, name: "influenza" },
	{user_id: admin, name: "mouse" },
	{user_id: admin, name: "rabbit"},
	{user_id: admin, name: "rat"   },
	{user_id: admin, name: "savidinii" },
	{user_id: admin, name: "sheep" },
	{user_id: admin, name: "synthetic" }
])

SequencingPlatform.delete_all
SequencingPlatform.create!([
	{user_id: admin, name: "Illumina MiSeq"},
	{user_id: admin, name: "Illumina HiSeq 2000"},
	{user_id: admin, name: "Illumina HiSeq 4000"}
])

ExperimentType.delete_all
ExperimentType.create!([
	{user_id: admin, name: "ChIP-Seq"},
	{user_id: admin, name: "ATAC-Seq"}
])

ReferenceGenome.delete_all
ReferenceGenome.create!([
	{user_id: admin, name: "UCSC hg19", url: "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/"},
	{user_id: admin, name: "NCBI GRCh37",url: "http://www.ncbi.nlm.nih.gov/projects/genome/assembly/grc/human"},
	{user_id: admin, name: "UCSC hg38", url: "http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/"},
	{user_id: admin, name: "NCBI GRCh38", url: "http://www.ncbi.nlm.nih.gov/projects/genome/assembly/grc/human"}
])

Chromosome.delete_all
hg38 = ReferenceGenome.find_by(name: "UCSC hg38").id
Chromosome.create!([
	{user_id: admin, reference_genome_id: hg38, name: "chr1" },
	{user_id: admin, reference_genome_id: hg38, name: "chr2" },
	{user_id: admin, reference_genome_id: hg38, name: "chr3" },
	{user_id: admin, reference_genome_id: hg38, name: "chr4" },
	{user_id: admin, reference_genome_id: hg38, name: "chr5" },
	{user_id: admin, reference_genome_id: hg38, name: "chr6" },
	{user_id: admin, reference_genome_id: hg38, name: "chr7" },
	{user_id: admin, reference_genome_id: hg38, name: "chr8" },
	{user_id: admin, reference_genome_id: hg38, name: "chr9" },
	{user_id: admin, reference_genome_id: hg38, name: "chr10" },
	{user_id: admin, reference_genome_id: hg38, name: "chr11" },
	{user_id: admin, reference_genome_id: hg38, name: "chr12" },
	{user_id: admin, reference_genome_id: hg38, name: "chr13" },
	{user_id: admin, reference_genome_id: hg38, name: "chr14" },
	{user_id: admin, reference_genome_id: hg38, name: "chr15" },
	{user_id: admin, reference_genome_id: hg38, name: "chr16" },
	{user_id: admin, reference_genome_id: hg38, name: "chr17" },
	{user_id: admin, reference_genome_id: hg38, name: "chr18" },
	{user_id: admin, reference_genome_id: hg38, name: "chr19" },
	{user_id: admin, reference_genome_id: hg38, name: "chr20" },
	{user_id: admin, reference_genome_id: hg38, name: "chr21" },
	{user_id: admin, reference_genome_id: hg38, name: "chr22" },
	{user_id: admin, reference_genome_id: hg38, name: "chrM" },
	{user_id: admin, reference_genome_id: hg38, name: "chrX" },
	{user_id: admin, reference_genome_id: hg38, name: "chrY" }
])

Target.delete_all
Target.create!([
{user_id: admin, name: "RELB-human", encode_identifier: "RELB-human"},
{user_id: admin, name: "CTCF-human", encode_identifier: "CTCF-human"}
])

Antibody.delete_all
Antibody.create!([
{user_id: admin, name: "ENCAB140SNC", organism_id: Organism.find_by!(name: "human").id, vendor_product_identifier: "A302-183A", vendor_id: Vendor.find_by!(encode_identifier: "bethyl-labs").id, clonality: "polyclonal", target_id: Target.find_by!(encode_identifier: "RELB-human").id, antibody_purifications: [AntibodyPurification.find_by!(name: "affinity")], lot_identifier: 1},
{user_id: admin, name: "ENCAB830JLB", organism_id: Organism.find_by!(name: "human").id, vendor_product_identifier: "07-729", vendor_id: Vendor.find_by!(encode_identifier: "millipore").id, clonality: "polyclonal", target_id: Target.find_by!(encode_identifier: "CTCF-human").id, antibody_purifications: [], lot_identifier: 2599305}
])

Biosample.delete_all
Biosample.create!([
	{user_id: admin, biosample_term_name_id: BiosampleTermName.find_by!(name: "HEK293").id, name: "ENCBS826GBM", encid: "ENCBS826GBM", description: "HEK293 cell line stably expressing N-terminal tagged eGFP-RBAK under the control of a CMV promoter.", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of HEK293").id, lot_identifier: "GR158277-1", vendor_id: Vendor.find_by!(encode_identifier: "coriell").id, vendor_product_identifier: "WH0008531M2", documents: [Document.first]},

{user_id: admin, biosample_term_name_id: BiosampleTermName.find_by!(name: "HEK293").id, name: "ENCBS758JEW", encid: "ENCBS758JEW", description: "HEK293 cell line stably expressing N-terminal tagged eGFP-RBAK under the control of a CMV promoter.", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of HEK293").id, lot_identifier: "GR158277-1", vendor_id: Vendor.find_by!(encode_identifier: "coriell").id, vendor_product_identifier: "WH0008531M2", documents: [Document.first]},

{user_id: admin, biosample_term_name_id: BiosampleTermName.find_by!(name: "GM12878").id, name: "ENCBS389LEA", encid: "ENCBS389LEA", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of GM12878").id, vendor_id: Vendor.find_by!(encode_identifier: "coriell").id, vendor_product_identifier: "GM12878", documents: [Document.second]},

{user_id: admin, biosample_term_name_id: BiosampleTermName.find_by!(name: "GM12878").id, name: "ENCBS488GLI", encid: "ENCBS488GLI", biosample_type_id: BiosampleType.find_by!(name: "immortalized cell line").id, donor_id: Donor.find_by!(name: "encode:donor of GM12878").id, vendor_id: Vendor.find_by!(encode_identifier: "coriell").id, vendor_product_identifier: "GM12878", documents: [Document.second],culture_harvest_date: "2014-06-05"}
])

Library.delete_all
Library.create!([
	{user_id: admin, name: "lib1", sequencing_library_prep_kit_id: truseq_ht_kits_id, nucleic_acid_term_id: NucleicAcidTerm.find_by!(name: "DNA").id, biosample_id: Biosample.find_by!(name: "ENCBS488GLI").id, size_range: "450-650", documents: [Document.second],strand_specific: false},
#
	{user_id: admin, name: "lib2", sequencing_library_prep_kit_id: truseq_ht_kits_id, nucleic_acid_term_id: NucleicAcidTerm.find_by!(name: "DNA").id, biosample_id: Biosample.find_by!(name: "ENCBS389LEA").id, size_range: "450-650", documents: [Document.second],strand_specific: false}
])
	
