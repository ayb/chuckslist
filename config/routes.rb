ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  
  map.connect 'update_category/:id', :controller => 'admin', :action => 'update_category'
    # maps a route of
  # http://chuckslist.org/admin/ 
  # to admin login screen
  map.connect 'admin', :controller => 'admin', :action => 'index'
  
  #maps route to admin/logout
  map.connect 'logout', :controller => 'admin', :action => 'destroy'
  
  #maps route to admin/login
  map.connect 'login', :controller => 'admin', :action =>'index'
  
  #maps route to admin/pwd
  map.connect 'password', :controller => 'admin', :action =>'pwd'
  
  #maps route to admin/manager
  map.connect 'manager', :controller => 'admin', :action =>'manager'
  
  #maps route to admin/authors
  map.connect 'authors', :controller => 'admin', :action => 'authors'
  
  #maps route to admin/category
  map.connect 'category', :controller => 'admin', :action =>'category'
  
  #maps route to admin/user
  map.connect 'user', :controller => 'admin', :action => 'user'
  
  #maps route to admin/parent_category
  map.connect 'parent', :controller => 'admin', :action => 'parent_category'

  # maps route to rss/atom feed
  map.connect 'feed', :controller => 'ads', :action => 'feed'
  
  # maps a route of http://chuckslist.org/forsale/ to list all ads with the category slug 'forsale'
  map.connect ':slug', :controller => 'ads', :action => 'list'
  
  map.connect ':slug/feed', :controller => 'ads', :action => 'category_feed'
  
  # maps a route of /destroy/hash/ to ads controller, action destroy
  map.connect 'ads/destroy/:activation_hash', :controller => 'ads', :action => 'destroy', :method => :post
  
  # maps a route of
  # http://chuckslist.org/activate/6e042790-d1a5-012a-f3ee-0011243b04a2
  # to the ads controller, activation
  map.connect 'activate/:activation_hash', :controller => 'ads', :action => 'activate'
  
  
  # maps a route of
  # http://chuckslist.org/edit/6e042790-d1a5-012a-f3ee-0011243b04a2
  # to the ads controller, edit
  map.connect 'ads/edit/:activation_hash', :controller => 'ads', :action => 'edit'
  
  # maps /ads/manage/hash to ads controller, activation hash
  map.connect 'ads/manage/:activation_hash', :controller => 'ads', :action => 'manage'
  
  
  #map.resources :ads
  #, :collection => { :list => :get, :create => :post, :post => :get }

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "main", :action => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
