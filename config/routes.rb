SnyderEncode::Application.routes.draw do

  resources :genome_locations
  resources :barcodes
  resources :sequencing_library_prep_kits
  resources :library_fragmentation_methods
  resources :biosample_term_names


  resources :sequencing_centers

  namespace :admin do
  	root "application#index"

		resources :users do
			member do
				patch :archive
			end
		end
  end

	resources :sequencing_requests do
		get :select_library, on: :collection
  	resources :sequencing_results do
			get :new_barcode_result, on: :member
			resources :barcode_sequencing_results
		end
	end

  devise_for :users

	resources :attachments, only: [:show,:new]

	resources :welcome, only: [:index]

  resources :reference_genomes do
	  resources :chromosomes
	end

  resources :experiment_types

  resources :sequencing_platforms

  resources :libraries

  resources :antibodies

	resources :antibody_purifications

  resources :organisms

  resources :targets

  resources :isotypes

  resources :biosamples do
		get :select_biosample_term_name, on: :collection
	end

  resources :donors

  resources :vendors

  resources :documents do
		post :save, on: :collection
		get  :document, on: :member
	end

  resources :document_types

  resources :biosample_types

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
