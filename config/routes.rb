Rails.application.routes.draw do

  # devise_for :users
  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      :registrations => 'users/registrations',
      :passwords => 'users/passwords',
    }
  end

  get 'users/my' => 'users#my'
  get 'users/export-words' => 'users#export_words'
  get 'users/export-users' => 'users#export_users'
  # resources :users, :only => [:index, :show,:edit]
  get 'users' => 'users#index',as: 'users'
  get 'users/:id' => 'users#show',as: 'show_user'
  get 'users/:id/edit' => 'users#edit',as: 'edit_user' 
  patch 'users/:id/edit' => 'users#update',as: 'user' 

  get 'words/edit/section/:section_no' => 'words#words_edit',as: 'words_edit_section'
  # get 'words/view/section/:section_no' => 'words#view',as: 'words_view_section'
  get 'test/words/' => 'words#words_test',as: 'words_view2_section'
  get 'words/help' => 'words#help',as: 'words_help'

  resources :words do
    collection do
      get :search
      # get :learn
      # get :new_multi
      # get :ajax_test
      # post :create_multi
      # post :fav
    end
  end


  # post 'ajax_test_post' => 'words#ajax_test_post'
  # patch 'ajax_test_post_update' =>'words#ajax_test_post_update'
  # delete 'ajax_test_post_delete' =>'words#ajax_test_post_delete'
  post    'ajax/words' => 'words#ajax_words_create'
  patch   'ajax/words' => 'words#ajax_words_update'
  put   'ajax/words' => 'words#ajax_words_update'
  delete  'ajax/words' => 'words#ajax_words_delete'
  post    'ajax/words/fav' => 'words#fav'


  get 'terms-of-use' =>'documents#terms'

  root to: 'words#index'
  get '*anything' => 'errors#routing_error'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
