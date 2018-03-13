Pulsar::Application.routes.draw do

  resources :treatments do
    get :select_options, on: :collection
  end

  resources :treatment_term_names do
    get :select_options, on: :collection
  end

  resources :pcrs
  resources :pcr_master_mixes
  resources :analyses do
		get :add_merged_file, on: :collection
	end
  resources :data_file_types
  resources :file_references
  resources :data_storage_providers
  resources :data_storages do
    get :select_options, on: :collection
		get :get_base_path, on: :member
		get :customize_for_data_storage_provider, on: :collection
	end
  resources :concentration_units
  resources :single_cell_sortings do
		get :add_plate, on: :member
		get :add_sorting_biosample, on: :member	
		get :add_library_prototype, on: :member
		get :new_analysis, on: :member
	end
  resources :addresses
  resources :plates do
		get :show_barcodes, on: :member
		resources :wells, except: [:index, :new, :destroy]
	end
  resources :paired_barcodes
  resources :crispr_modifications do
		#crisprs only belong to biosamples.
		get :new_pcr_validation, on: :member
		get :select_crispr_construct, on: :collection
		#select_crispr_construct on collection instead of member b/c the user selects this when creating or editing the crispr object, and
		# since the crispr won't have an id yet when being created, we can't use :member.
		get :select_chromosome_on_reference_genome, on: :collection
	end
  resources :crispr_constructs

  resources :donor_constructs do
		get :select_construct_tag, on: :collection
	end

  resources :construct_tags

  resources :cloning_vectors do
    get :select_options, on: :collection
  end

  resources :genome_locations
  resources :sequencing_library_prep_kits do
		get :paired_end_kits, on: :collection
  	resources :barcodes, except: [:index]
	end
  resources :library_fragmentation_methods
  resources :biosample_term_names do
    get :select_options, on: :collection
  end

  resources :sequencing_centers

	namespace :api do
		resources :biosamples
		resources :construct_tags
		resources :crispr_constructs
		resources :sequencing_requests do
			get :find_by_name, on: :collection
			post :add_crispr_modification, on: :member
		end

	end

  namespace :admin do
  	root "application#index"

		resources :users do
			member do
				patch :archive
				patch :unarchive
    		get  :show_api_key
    		get  :remove_api_key
			end
		end
  end

	resources :sequencing_requests do
		get :select_scs, on: :member
		get :select_scs_plates, on: :member
		get :select_library, on: :member
  	resources :sequencing_runs do
			get :add_storage_location, on: :member
			get :new_sequencing_result, on: :member
			resources :sequencing_results do
				get :get_barcode_selector, on: :collection
				get :get_library_selector, on: :collection
			end
		end
	end

  #Add non-nested index view for sequencing_runs:
  #get sequencing_runs: "sequencing_runs#all", as: :sequencing_runs

  devise_for :users, controllers: {
		registrations: 'registrations'
	}
  resources :users, only: [:show, :edit] do
    post :generate_api_key, on: :member
    get  :show_api_key, on: :member
    get  :remove_api_key, on: :member
		patch :archive, on: :member
  end 
		

	resources :attachments, only: [:show,:new]

	resources :welcome, only: [:index] do
		get :search, on: :collection
	end

  resources :reference_genomes do
	  resources :chromosomes, except: [:index]
	end

  resources :experiment_types

  resources :sequencing_platforms

  resources :libraries do
		get :select_paired_barcode, on: :collection
		get :select_barcode, on: :collection
	end

  resources :antibodies

	resources :antibody_purifications

  resources :organisms

  resources :targets do
    get :select_options, on: :collection
  end

  resources :isotypes

  resources :biosamples do
		get :select_biosample_term_name, on: :collection
		get :add_crispr_modification, on: :member
	end

  resources :donors do
    get :select_options, on: :collection
  end

  resources :vendors do
    get :select_options, on: :collection
  end

  resources :documents do
    get :select_options, on: :collection
		post :save, on: :collection
		get  :document, on: :member
	end

  resources :document_types

  resources :biosample_types do
    get :select_options, on: :collection
  end

  resources :nucleic_acid_terms

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
