Rails.application.routes.draw do

  root 'index#index'

  # devise routes
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  get 'playlists/index'
  # teammaking posts routes
  resources :posts do
    post "/like", to: "likes#like_toggle"
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  resources :follows, only: [:create, :destroy] # 팔로우 ,팔로우 취소 routes
  
  resources :teams, only: [:create, :destroy] do # 팀 만들기, 삭제하기.
     post "/close", to: "teams#close" # 팀원 신청 마감
     get "/teamcomments", to: "teams#showallcomments" # 팀원 댓글 보여주기.
    resources :teamcomments, only:[:create, :destroy, :edit, :update] 
    resources :teammembers, only: [:create, :destroy] do# 팀원 신청, 팀원 신청 취소
      post "/grant", to: "teammembers#grant" # 팀원 신청시 승인
      post "/reject", to: "teammembers#reject" # 팀원 신청시 거절
    end
  end
  # music posts routes
  resources :musicposts do
    post "/like", to: "mplikes#mplike_toggle"
    post "/playlist", to: "playlists#playlist_toggle"
    resources :mpcomments, only: [:create, :destroy, :edit, :update]
  end
  
  # messenger routes
  get 'messenger/index'
  get 'messenger/write'
  post 'messenger/create'
  get 'messenger/view/:messenger_id' => 'messenger#view'
  get 'messenger/view2/:receive_id' => 'messenger#view2'
  get 'messenger/destroy1/:messenger_id' => 'messenger#destroy1'
  get 'messenger/destroy2/:receive_id' => 'messenger#destroy2'
  
  # MyPage routes 
  get 'mypages/:user_id/myteam' => 'mypages#myteam'
  get 'mypages/following' => 'mypages#following'
  get 'mypages/:user_id/user_profile' => 'mypages#user_profile'
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
