class AddGenomicIntegrationSiteToCrisprs < ActiveRecord::Migration
  def change
    add_reference :crisprs, :genomic_integration_site, index: true
		add_foreign_key :crisprs, :genome_locations, column: 	:genomic_integration_site_id
  end
end
