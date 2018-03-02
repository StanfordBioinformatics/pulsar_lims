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

DataFileType.delete_all
DataFileType.create!([
	{user_id: admin, name: "BAM"},
	{user_id: admin, name: "CSV", description: "Comma-separated values"},
	{user_id: admin, name: "BED"},
	{user_id: admin, name: "FASTQ"},
	{user_id: admin, name: "TSV", description: "Tab-separated values"}
])

DataStorageProvider.delete_all
DataStorageProvider.create!([
	{user_id: admin, name: "AWS S3 Bucket", bucket_storage: true},
	{user_id: admin, name: "Azure Storage Account", bucket_storage: true},
	{user_id: admin, name: "DNAnexus", bucket_storage: false},
	{user_id: admin, name: "Google Storage Bucket", bucket_storage: true}
])

PcrMasterMix.delete_all
PcrMasterMix.create!([
	{user_id: admin, name: "LongAMp Taq 2X Master Mix", vendor_id: Vendor.find_by(name: "New England BioLabs").id, vendor_product_identifier: "M0782S", lot_identifier: "0321708", vendor_product_url: "https://www.neb.com/products/m0287-longamp-taq-2x-master-mix#Product%20Information"}
])

SequencingCenter.delete_all
SequencingCenter.create!([
	{user_id: admin, name: "Stanford Genome Sequencing Service Center", url: "http://med.stanford.edu/gssc.html", address: "3155 Porter Dr; Palo Alto, CA 94304"}
])

ConcentrationUnit.delete_all
ConcentrationUnit.create!([
	{user_id: admin, name: "cells" },
	{user_id: admin, name: "cell-equivalent" },
	{user_id: admin, name: "µg" },
	{user_id: admin, name: "ng" },
	{user_id: admin, name: "pg" },
	{user_id: admin, name: "mg" },
	{user_id: admin, name: "nM" }
])
	

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
	{user_id: admin, name: "Millipore", encode_identifier: "millipore", url: "http://www.emdmillipore.com"},
	{user_id: admin, name: "genomics-online", encode_identifier: "", url: "https://www.genomics-online.com"},
	{user_id: admin, name: "Greenleaf Lab", encode_identifier: "", url: "http://greenleaf.stanford.edu"}
])

CloningVector.delete_all
CloningVector.create!([
	{user_id: admin, name: "pMD18-T Simple", product_url: "https://www.genomics-online.com/vector-backbone/37/pmd18-t-simple/"}
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
nebnext_oligos_E7600 = Rails.root.join("lib","seeds","nebnext_oligos_E7600.pdf")
Document.delete_all
Document.create!([
	{user_id: admin, name: File.basename(illumina_truseq_dna_pcr_free), content_type: "application/pdf", 
		data: File.open(illumina_truseq_dna_pcr_free,"rb").read(), is_protocol: false, 
		description: "Illumina reference guide.",
		document_type_id: DocumentType.find_by(name: "general protocol").id},

	{user_id: admin, name: File.basename(illumina_adapter_letter), content_type: "application/pdf", 
		data: File.open(illumina_adapter_letter,"rb").read(), is_protocol: false, 
		description: "Illumina barcodes for various library prep kits.",
		document_type_id: DocumentType.find_by(name: "general protocol").id},
	{user_id: admin, name: File.basename(nebnext_oligos_E7600), content_type: "application/pdf", 
		data: File.open(nebnext_oligos_E7600,"rb").read(), is_protocol: false, 
		description: "The NEBNext Multiplex Oligos for Illumina (Dual Index Primers Set 1) contains the adaptor and index primers that are ideally suited for multiplex sample preparation for next-generation sequencing on the Illumina platform.",
		document_type_id: DocumentType.find_by(name: "general protocol").id}
])

SequencingLibraryPrepKit.delete_all
SequencingLibraryPrepKit.create!([
	{user_id: admin, name: "Illumina TruSeq HT Kits", supports_paired_end: true, documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")], vendor_id: Vendor.find_by(name: "Illumina").id, description: "Includes TruSeq DNA PCR-Free HT, TruSeq Nano HT, TruSeq Stranded mRNA HT, and TruSeq Total RNA HT"},
	{user_id: admin, name: "Illumina TruSeq LT Kits", documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")] ,vendor_id: Vendor.find_by(name: "Illumina").id, description: "Includes TruSeq DNA PCR-Free LT, TruSeq Nano DNA LT, TruSeq DNA v1/v2/LT (obsolete), TruSeq RNA v1/v2/LT, TruSeq Stranded mRNA LT, TruSeq Stranded Total RNA LT, TruSeq RNA Access, and TruSeq ChIP"},
	{user_id: admin, name: "Illumina Nextera Kits", supports_paired_end: true, documents: [Document.find_by(name: "illumina-adapter-sequences_1000000002694-01.pdf")] ,vendor_id: Vendor.find_by(name: "Illumina").id, description: "Includes Nextera DNA, Nextera XT, Nextera Enrichment (obsolete), and Nextera Rapid Capture. Does not include Nextera XT Index Kit v2."},
	{user_id: admin, name: "NEBNext Multiplex Oligos for Illumina (Dual Index Primers Set 1)", supports_paired_end: true, documents: [Document.find_by(name: "nebnext_oligos_E7600.pdf")] ,vendor_id: Vendor.find_by(name: "New England BioLabs").id, vendor_product_identifier: "E7600S", description: "Contains the adaptor and index primers that are ideally suited for multiplex sample preparation for next-generation sequencing on the Illumina platform. Designed for use with specific NEBNext Kits, see https://www.neb.com/~/media/Catalog/All-Products/E7CFA11A57424D299FAA2AF513787BBE/Datacards%20or%20Manuals/manualE7600.pdf."},
	{user_id: admin, name: "Custom nextera Greenleaf lab", supports_paired_end: true, vendor_id: Vendor.find_by(name: "Greenleaf Lab").id, description: "Contains custom barcodes based off of Nextera, designed in the Greenleaf lab."}
])

truseq_ht_kits_id = SequencingLibraryPrepKit.find_by!(name: "Illumina TruSeq HT Kits").id
truseq_lt_kits_id = SequencingLibraryPrepKit.find_by!(name: "Illumina TruSeq LT Kits").id
nextera_kits_id = SequencingLibraryPrepKit.find_by!(name: "Illumina Nextera Kits").id
nebnext_duel_set1_id = SequencingLibraryPrepKit.find_by!(name: "NEBNext Multiplex Oligos for Illumina (Dual Index Primers Set 1)").id
greenleaf_kit_id = SequencingLibraryPrepKit.find_by!(name: "Custom nextera Greenleaf lab").id

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

{user_id: admin, name: "TAAGGCGA", sequence: "TAAGGCGA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGTACTAG", sequence: "CGTACTAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGGCAGAA", sequence: "AGGCAGAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCCTGAGC", sequence: "TCCTGAGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGACTCCT", sequence: "GGACTCCT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAGGCATG", sequence: "TAGGCATG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTCTCTAC", sequence: "CTCTCTAC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CAGAGAGG", sequence: "CAGAGAGG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCTACGCT", sequence: "GCTACGCT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGAGGCTG", sequence: "CGAGGCTG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AAGAGGCA", sequence: "AAGAGGCA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTAGAGGA", sequence: "GTAGAGGA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGGATCTG", sequence: "TGGATCTG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCGTTTGT", sequence: "CCGTTTGT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGCTGGGT", sequence: "TGCTGGGT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGGTTGGG", sequence: "AGGTTGGG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTGTGGTG", sequence: "GTGTGGTG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGGGTTTC", sequence: "TGGGTTTC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGGTCACA", sequence: "TGGTCACA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTGACCCT", sequence: "TTGACCCT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGCGGACA", sequence: "CGCGGACA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTCCATAT", sequence: "TTCCATAT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AATTCGTT", sequence: "AATTCGTT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGCGTCGA", sequence: "GGCGTCGA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACAAAGTG", sequence: "ACAAAGTG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TACTTGAA", sequence: "TACTTGAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTGATAGC", sequence: "GTGATAGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGTAGATT", sequence: "AGTAGATT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATTGCCGG", sequence: "ATTGCCGG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTGCTAAG", sequence: "TTGCTAAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATAAGTTA", sequence: "ATAAGTTA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATCACTCG", sequence: "ATCACTCG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTTAACAG", sequence: "GTTAACAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AATGGTAG", sequence: "AATGGTAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GAGCACGT", sequence: "GAGCACGT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTTCGTCA", sequence: "TTTCGTCA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CAAGAATT", sequence: "CAAGAATT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GAAATGCC", sequence: "GAAATGCC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AACGCCAT", sequence: "AACGCCAT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCTCGCAG", sequence: "CCTCGCAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TACACCTC", sequence: "TACACCTC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGTCATTT", sequence: "GGTCATTT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CAATCTTA", sequence: "CAATCTTA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGTGCCTT", sequence: "TGTGCCTT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCTTATTA", sequence: "TCTTATTA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GACTTAGT", sequence: "GACTTAGT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGACCAGC", sequence: "AGACCAGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AAATACAG", sequence: "AAATACAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTATGAAA", sequence: "TTATGAAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTTGGGTC", sequence: "CTTGGGTC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCAAATAA", sequence: "CCAAATAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCGTTAAA", sequence: "GCGTTAAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CATCCTGT", sequence: "CATCCTGT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGAGTAAG", sequence: "GGAGTAAG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GACGCTCC", sequence: "GACGCTCC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTCGCGGC", sequence: "TTCGCGGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGGTTCCC", sequence: "CGGTTCCC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACCGGCTA", sequence: "ACCGGCTA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTCATGGG", sequence: "CTCATGGG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTTAATGC", sequence: "TTTAATGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AAACGGTC", sequence: "AAACGGTC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GATCCAAA", sequence: "GATCCAAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATGATGAT", sequence: "ATGATGAT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCAACACG", sequence: "CCAACACG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAACAACA", sequence: "TAACAACA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGTAAACC", sequence: "GGTAAACC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CATCGACC", sequence: "CATCGACC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATGGGAAC", sequence: "ATGGGAAC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGGCCAAT", sequence: "CGGCCAAT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGGAATGA", sequence: "GGGAATGA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTATTCGG", sequence: "GTATTCGG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCAGCTAT", sequence: "TCAGCTAT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATTTATCT", sequence: "ATTTATCT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACAGTTGC", sequence: "ACAGTTGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCCGAGAT", sequence: "CCCGAGAT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAATGTCT", sequence: "TAATGTCT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCCAATTC", sequence: "GCCAATTC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGCCGTGC", sequence: "CGCCGTGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTGACCGA", sequence: "CTGACCGA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CATTTCGA", sequence: "CATTTCGA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCTTGCCA", sequence: "GCTTGCCA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTCTACCA", sequence: "TTCTACCA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACGTGACG", sequence: "ACGTGACG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGTCCGCG", sequence: "TGTCCGCG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTAAACTT", sequence: "TTAAACTT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACCACAAC", sequence: "ACCACAAC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCCTCTGG", sequence: "GCCTCTGG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCGCCCAC", sequence: "TCGCCCAC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CACTAGGC", sequence: "CACTAGGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCGAAGCC", sequence: "TCGAAGCC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCATGTAC", sequence: "GCATGTAC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTTCGAGT", sequence: "GTTCGAGT", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCGGGCGC", sequence: "CCGGGCGC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGATTTAA", sequence: "AGATTTAA", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CACCATTG", sequence: "CACCATTG", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AATAAGAC", sequence: "AATAAGAC", index_number: 1, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAGATCGC", sequence: "TAGATCGC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTCTCTAT", sequence: "CTCTCTAT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TATCCTCT", sequence: "TATCCTCT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGAGTAGA", sequence: "AGAGTAGA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTAAGGAG", sequence: "GTAAGGAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACTGCATA", sequence: "ACTGCATA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AAGGAGTA", sequence: "AAGGAGTA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTAAGCCT", sequence: "CTAAGCCT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGGAAATC", sequence: "TGGAAATC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AACATGAT", sequence: "AACATGAT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGATGAAA", sequence: "TGATGAAA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTCGGACT", sequence: "GTCGGACT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTTCTAGC", sequence: "TTTCTAGC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAACCAAG", sequence: "TAACCAAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTGTATCG", sequence: "GTGTATCG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCCATCAA", sequence: "TCCATCAA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTCGTGCA", sequence: "TTCGTGCA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGGTTGCC", sequence: "AGGTTGCC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCTTATGT", sequence: "CCTTATGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CAGCAACG", sequence: "CAGCAACG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGTTCAAT", sequence: "GGTTCAAT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACATTCGT", sequence: "ACATTCGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GATTCCCA", sequence: "GATTCCCA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGGACTGC", sequence: "CGGACTGC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGCCGTTC", sequence: "AGCCGTTC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATTGGGTC", sequence: "ATTGGGTC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGCATACT", sequence: "TGCATACT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGGCTTGG", sequence: "GGGCTTGG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GACGTGGC", sequence: "GACGTGGC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCAAATTT", sequence: "GCAAATTT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCAGCCTC", sequence: "GCAGCCTC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCCGAGTT", sequence: "TCCGAGTT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCATTAAG", sequence: "GCATTAAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACGATAAC", sequence: "ACGATAAC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCTGCGGG", sequence: "CCTGCGGG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGATTGTT", sequence: "TGATTGTT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGCACGGA", sequence: "GGCACGGA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GATCATTC", sequence: "GATCATTC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATGGTCAT", sequence: "ATGGTCAT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGTACCAA", sequence: "CGTACCAA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCAGTTTA", sequence: "CCAGTTTA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACCGGCCC", sequence: "ACCGGCCC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTAGAAGT", sequence: "CTAGAAGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGCCAGAT", sequence: "CGCCAGAT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCACATGG", sequence: "TCACATGG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GAACTCGA", sequence: "GAACTCGA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCACCGTT", sequence: "CCACCGTT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAAGTTAC", sequence: "TAAGTTAC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GAGACGTG", sequence: "GAGACGTG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTGCCTAA", sequence: "TTGCCTAA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTAACTTG", sequence: "TTAACTTG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTTTAACA", sequence: "CTTTAACA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGTAGACC", sequence: "CGTAGACC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TATTTGCG", sequence: "TATTTGCG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATCCAGGA", sequence: "ATCCAGGA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGTTCCTG", sequence: "TGTTCCTG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACGCGCAG", sequence: "ACGCGCAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCTGGCGA", sequence: "TCTGGCGA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AATCTACA", sequence: "AATCTACA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TACTGACC", sequence: "TACTGACC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CGATAGGG", sequence: "CGATAGGG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACTTAGAA", sequence: "ACTTAGAA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGAGATCT", sequence: "AGAGATCT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGTGAAGG", sequence: "GGTGAAGG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATCGAATG", sequence: "ATCGAATG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TCAAGAGC", sequence: "TCAAGAGC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCCCACGT", sequence: "GCCCACGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TGGGCGGT", sequence: "TGGGCGGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCCTTGGA", sequence: "CCCTTGGA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATTACCGT", sequence: "ATTACCGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGTCCGAG", sequence: "AGTCCGAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ACTTGTTG", sequence: "ACTTGTTG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTAATACA", sequence: "GTAATACA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGCGTCTA", sequence: "GGCGTCTA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCGCTGCT", sequence: "GCGCTGCT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTGCCATT", sequence: "GTGCCATT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TAGGTATG", sequence: "TAGGTATG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AACACCTA", sequence: "AACACCTA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTCCGAAC", sequence: "CTCCGAAC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CAACGGCA", sequence: "CAACGGCA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CAATGTAG", sequence: "CAATGTAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GGCTACCC", sequence: "GGCTACCC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AAAGTCCG", sequence: "AAAGTCCG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTCCGCGG", sequence: "TTCCGCGG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "AGGCACTT", sequence: "AGGCACTT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CTTCAGTG", sequence: "CTTCAGTG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GCCGGTAG", sequence: "GCCGGTAG", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "TTCAATCC", sequence: "TTCAATCC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCACACAC", sequence: "CCACACAC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "ATATTATC", sequence: "ATATTATC", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "CCGAAGCA", sequence: "CCGAAGCA", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id},
{user_id: admin, name: "GTATCGGT", sequence: "GTATCGGT", index_number: 2, sequencing_library_prep_kit_id: greenleaf_kit_id}
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
grch37 = ReferenceGenome.find_by(name: "NCBI GRCh37").id
grch38 = ReferenceGenome.find_by(name: "NCBI GRCh38").id
hg19 = ReferenceGenome.find_by(name: "UCSC hg19").id
hg38 = ReferenceGenome.find_by(name: "UCSC hg38").id
Chromosome.create!([
	{user_id: admin, reference_genome_id: grch37, name: "NC_000001"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000002"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000003"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000004"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000005"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000006"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000007"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000008"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000009"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000010"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000011"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000012"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000013"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000014"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000015"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000016"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000017"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000018"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000019"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000020"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000021"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000022"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000023"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_000024"},
	{user_id: admin, reference_genome_id: grch37, name: "NC_012920"},

	{user_id: admin, reference_genome_id: grch38, name: "NC_000001"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000002"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000003"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000004"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000005"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000006"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000007"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000008"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000009"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000010"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000011"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000012"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000013"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000014"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000015"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000016"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000017"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000018"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000019"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000020"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000021"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000022"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000023"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_000024"},
	{user_id: admin, reference_genome_id: grch38, name: "NC_012920"},

	{user_id: admin, reference_genome_id: hg19, name: "chr1" },
	{user_id: admin, reference_genome_id: hg19, name: "chr2" },
	{user_id: admin, reference_genome_id: hg19, name: "chr3" },
	{user_id: admin, reference_genome_id: hg19, name: "chr4" },
	{user_id: admin, reference_genome_id: hg19, name: "chr5" },
	{user_id: admin, reference_genome_id: hg19, name: "chr6" },
	{user_id: admin, reference_genome_id: hg19, name: "chr7" },
	{user_id: admin, reference_genome_id: hg19, name: "chr8" },
	{user_id: admin, reference_genome_id: hg19, name: "chr9" },
	{user_id: admin, reference_genome_id: hg19, name: "chr10" },
	{user_id: admin, reference_genome_id: hg19, name: "chr11" },
	{user_id: admin, reference_genome_id: hg19, name: "chr12" },
	{user_id: admin, reference_genome_id: hg19, name: "chr13" },
	{user_id: admin, reference_genome_id: hg19, name: "chr14" },
	{user_id: admin, reference_genome_id: hg19, name: "chr15" },
	{user_id: admin, reference_genome_id: hg19, name: "chr16" },
	{user_id: admin, reference_genome_id: hg19, name: "chr17" },
	{user_id: admin, reference_genome_id: hg19, name: "chr18" },
	{user_id: admin, reference_genome_id: hg19, name: "chr19" },
	{user_id: admin, reference_genome_id: hg19, name: "chr20" },
	{user_id: admin, reference_genome_id: hg19, name: "chr21" },
	{user_id: admin, reference_genome_id: hg19, name: "chr22" },
	{user_id: admin, reference_genome_id: hg19, name: "chrM" },
	{user_id: admin, reference_genome_id: hg19, name: "chrX" },
	{user_id: admin, reference_genome_id: hg19, name: "chrY" },

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

TreatmentTermName.delete_all
TreatmentTermName.create!([
  {user_id: admin, name: "17β-hydroxy-5α-androstan-3-one", accession: "CHEBI:16330", 
   description: "A 17β-hydroxy steroid that is testosterone in which the 4,5 double bond has been reduced to a single bond with α-configuration at position 5."},
  {user_id: admin, name: "tumor necrosis factor", accession: "UniProtKB:P01375",
   description: "Cytokine that binds to TNFRSF1A/TNFR1 and TNFRSF1B/TNFBR. It is mainly secreted by macrophages and can induce cell death of certain tumor cell lines. It is potent pyrogen causing fever by direct action or by stimulation of interleukin-1 secretion and is implicated in the induction of cachexia, Under certain conditions it can stimulate cell proliferation and induce cell differentiation. Impairs regulatory T-cells (Treg) function in individuals with rheumatoid arthritis via FOXP3 dephosphorylation. Upregulates the expression of protein phosphatase 1 (PP1), which dephosphorylates the key 'Ser-418' residue of FOXP3, thereby inactivating FOXP3 and rendering Treg cells functionally defective (PubMed:23396208). Key mediator of cell death in the anticancer action of BCG-stimulated neutrophils in combination with DIABLO/SMAC mimetic in the RT4v6 bladder cancer cell line (PubMed:22517918)."}
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
	
