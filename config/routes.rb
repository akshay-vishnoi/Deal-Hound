DealHound::Application.routes.draw do

  root :to => 'commodities#index'
  controller :subscriptions do
    post 'subscription'
    get 'unsubscribe'
  end
  resources :commodities do
    member do
      get 'delete_img' => :del_image
    end
  end

  resources :deals do
    collection do
      post 'index'
      get 'show_commodities'
    end
  end
  resources :admins
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :delete
  end
  controller :categories do
    post 'edit_delete'
  end

  resources :users do
    member do
      get :edit_password
      put :save_password
      put :save_after_forget
    end
    collection do
      post :forget_password
      get :change_password
    end
  end
  resources :categories do
    resources :commodities, :only => [:index]
  end

  resources :vouchers
  resources :carts
  resources :line_items
  resources :orders



# Presentation

  # Singular Resource
    # match "profile" => "users#show"

    # resource :users


  # Nested Resource should be only 1 level deep
    # resources :magazines, :shallow => true do
    #   resources :ads do
    #     # resources :pages
    #   end
    # end

    # <%= link_to "Ad details", magazine_ad_path(@magazine, @ad) %>
    #  <%#= link_to "Ad details", url_for([@magazine, @ad]) %>
    # <%= link_to "Ad details", [@magazine, @ad] %>


  # Member and Collection
    # resources :products do
    #   member do
    #     get 'short'
    #     post 'toggle'
    #   end
    #   get 'short', :on => :member
    #   collection do
    #     get 'sold'
    #   end
    # end

  # Non Resourceful Routes
    
    # Bound Parameters
      # match ':controller(/:action(/:id))'
        # /photos/show/1 
        # can match index too as action and id are optional

    # Dynamic Segments
      # match ':controller/:action/:id/:user_id'
        # e.g. /photos/show/1/2 
        # params[:id] = 1, params[:user_id] = 2

    # Static Segments
      # match ':controller/:action/:id/with_user/:user_id'

    # Query String
      # match ':controller/:action/:id'
        # e.g. /photos/show/1?user_id=2

    # Defining Defaults
      # match 'photos/:id' => 'photos#show'
      # match 'users/:id' => 'users#show', :defaults => { :format => 'jpg' }

    # Naming Routes
      # match 'exit' => 'sessions#destroy', :as => :logout
        # function logout_url and logout_path
        # path = /exit

    # HTTP verb constraints
      # match 'photos/show' => 'photos#show', :via => :get
      # get 'users/show'
      # match 'products/show' => 'products#show', :via => [:get, :post]

    # Segment Constraints
      # match 'photos/:id' => 'photos#show', :constraints => { :id => /[A-Z]\d{5}/ }
      # match 'users/:id' => 'users#show', :id => /[A-Z]\d{5}/

      # Anchors cant be used
        # match '/:id' => 'posts#show', :constraints => {:id => /^\d/}

      # Routes are anchored at the start
        # match '/:id' => 'posts#show', :constraints => { :id => /\d.+[A-z]/ }
        # match '/:username' => 'users#show'

      # Request based Constraints
        # match "photos/show", :constraints => {:subdomain => "admin"}

    # Routes Globbing
      # match 'photos/*other' => 'photos#unknown'
        # *other can match to any path    

      # match 'books/*section/:title' => 'books#show'
        # params[:section] and params[:title]
      # match '*a/foo/*b' => 'test#index'
        # params[:a] amd params[:b]
        # foo/foo/foo
       # match '*pages' => 'pages#show'#, :format => false 
        # e.g. /foo/bar.json
        # params[:pages] = "foo/bar" and :format => json (Format of page)

    # Redirection
      # match "/stories" => redirect("/posts")
      # match "/stories/:name" => redirect("/posts/%{name}")
      # match "/stories/:name" => redirect {|params| "/posts/#{params[:name].pluralize}" }

    # Root
      # root :to => 'pages#main'

  # Customizing Resourceful Routes
    
    # Specify Controller
      # resources :photos, :controller => "images"
         # photos GET    /photos(.:format)          images#index

    # Specify Constraints
      # resources :photos, :constraints => {:id => /[A-Z][A-Z][0-9]+/}
      
      # constraints(:id => /[A-Z][A-Z][0-9]+/) do
      #   resources :photos
      #   resources :accounts
      # end

    # Overriding Named Helpers
      # resources :photos, :as => "images"

    # Overriding the new and edit Segments
      # resources :photos, :path_names => { :new => 'make', :edit => 'change' } 

    # Prefixing the Named Route Helpers
      # scope "admin" do
      #   resources :photos, :as => "admin_photos"
      # end

      # scope "admin", :as => "admin" do
      #   resources :photos, :accounts
      # end

      # scope ":username" do
      #   resources :posts
      # end

    # Restricting The Routes
      # resources :photos, :only => [:index, :show]
      # resources :photos, :except => :destroy

    # As in Nested Resources
      # resources :magazines do
      #   resources :ads, :as => 'periodical_ads'
      # end










  # namespace :admin do
  #   resources :posts,  :only => [:index, :show]
  # end
  # get 'login' => :new, :controller => :posts#,:on => :collection# || :member

  #/:account_id/projects, rather than /accounts/:account_id/projects
  # scope :path => ":account_id", :as => "account" do
  #   resources :products,  :only => [:index, :show]
  # end

  #route /posts (without the prefix /admin)
  # scope :module => "admin" do
  #   resources :posts,  :only => [:index, :show]
  # end

  # # prefix the posts resource's requests with '/admin'
  # scope :path => "/admin" do
  #   resources :posts,  :only => [:index, :show]
  # end

  # prefix the routing helper name: +sekret_posts_path+ instead of +posts_path+
  # scope :as => "sekret" do
  #   resources :posts,  :only => [:index, :show]
  # end

  # resources :posts, :module => "admin"
  # scope "/admin" do
    
  # end  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
    # match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
    # match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
    # resources :products do
    #   get 'pp'
    #   member do
    #     get 'short'
    #     post 'toggle'
    #   end
  
    #   collection do
    #     get 'sold'
    #   end
    # end

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
