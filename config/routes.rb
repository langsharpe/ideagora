Ideagora::Application.routes.draw do

  get "project_status/update"

  get "camps/message_board"

  get "welcome/index"
  get "welcome/dashboard"
  get "sign_in" => "sessions#new", :as => "sign_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "my_profile" => "users#edit", :as => "my_profile"
  get "projects" => "projects#all", :as => "projects"
  
  resources :camps do
    get 'message_board', :on => :member
  end
  
  resources :thoughts, :only => [:create, :index] do
    resources :likes, :only => [:create, :destroy]
    get 'like' => "likes#create", :as => 'like'
    get 'unlike' => "likes#destroy", :as => 'unlike'
  end
  resources :notices
  resources :discussions
  resources :sessions
  resources :talks do
    collection do
      get "calendar"
    end
  end
  resources :events
  resources :venues
  resources :users, :only => [:index, :show, :edit, :update] do
    resources :projects do
      member do
        get "restart"
        get "complete"
        get "cancel"
      end
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "welcome#index"
end
