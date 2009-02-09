ActionController::Routing::Routes.draw do |map|
  map.resources :thumbnails

  map.resources :videos, :member => {:rate => :post}
  map.best '/best', :controller => 'videos', :action => 'best'

  # Home Page
  map.root :controller => 'videos', :action => 'show'

  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  
  # Restful Authentication Resources
  map.resource :session
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
