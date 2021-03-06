Rails.application.routes.draw do
  root 'dashboard#index'
  
  get "/voicemail", :to => "tasks#voicemail", :as => :voicemail_tasks
  get "/broken", :to => "tasks#broken", :as => :broken_tasks
  get "/idle", :to => "tasks#idle", :as => :idle_tasks
  get "/unmatched", :to => "tasks#unmatched", :as => :unmatched_tasks
  get "/email", :to => "tasks#email", :as => :email_tasks
  get "/other", :to => "tasks#other", :as => :other_tasks
  
  resources :roles
  resources :tasks do
    collection { post :import }
    member do
      patch :resolved
      patch :pending
      patch :unpending
      patch :tasks
    end  
  end

  resources :sources

  devise_for :people
  
  
  resources :task_types
  resources :statuses
  
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
