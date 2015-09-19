Rails.application.routes.draw do
  get 'landings/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'signup#index'

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
  
  #Devise ->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

  # Get pages accessible to ALL users
  get "signup_start" => "signup#signup_start"
  get "create_company" => "signup#create_company"

  # Get pages accessible to all logged in users
  get "home" => "landings#home"
  get "events" => "landings#events"
  get "users" => "landings#users"
  get "request-help" => "landings#request-and-help"
  get "forum" => "forem/forums#index"

  # All post
  post "signup_username" => "signup#signup_username"
  post "create_company_post" => "signup#create_company_post"

  # Tutorail
  get "tutorial" => "tutorial#start"
  get "tutorial/2" => "tutorial#tutorial_2"
  get "tutorial/3" => "tutorial#tutorial_3"
  get "tutorial/4" => "tutorial#tutorial_4"
  post "new-company-tutorial" => "tutorial#new_company"
  post "new-loan-tutorial" => "tutorial#new_loan"
  get "wiki" => "wiki#index"

  # Shop
  get "payment" => "shop#payment"

  # Global Market
  get "market" => "market#index"
  post "market-search" => "market#search"
  post "market-sell" => "market#sell"
  post "market-buy" => "market#buy"
  get "update-orders" => "market#update_orders"

  # Comapny
  resources :companies
  get "profit-and-loss" => "companies#profitandloss"
  get "upgrade" => "companies#upgrades"
  get "employes/find" => "companies#employe_find"
  get "trade" => "companies#trade"
  get "load-dropdown" => "companies#load_dropdown"
  post "hire-employee" => "companies#hire_employee"
  post "decline-employee" => "companies#decline_employee"
  post "fire-employee" => "companies#fire_employee"
  post "employement-ad" => "companies#employement_ad"
  post "upgrade" => "companies#upgrade"
  post "build" => "companies#build"
  post "update-employee-building" => "companies#update_employee_building"

  # User
  get "/inbox" => "userpages#inbox"
  get "/users-companies" => "userpages#users_companies"
  get "/user/:id" => "userpages#userpage"

  # Invest
  get "/stock-market" => "invest#market"
  get "/find-investors" => "invest#investors"
  get "/investments" => "invest#investments"
  get "/loan/:id" => "invest#loan"
  post "/investors_submit_bank" => "invest#investors_submit_bank"
  post "/investors_submit_private" => "invest#investors_submit_private"
  post "/private_investement" => "invest#private_investement"


end
