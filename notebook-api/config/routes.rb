Rails.application.routes.draw do

  #Devise Token Auth
  mount_devise_token_auth_for 'User', at: 'auth'

  #Authentication
  #resources :auths, only: [:create]
  
  resources :kinds

  #V1
  # scope module: "v1" do #Query Paramenter
    # resources :contacts, :constraints => lambda { |request| request.params[:version] == "1" } do #Query Paramenter
  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :contacts do
      #Kind
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: "relationship/kind"

      #Phone
      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'

      resource :phone, only: [:update, :create, :destroy]
      resource :phone, only: [:update, :create, :destroy], path: 'relationships/phones'

      #Address
      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
    end
  end

  #V2
  # scope module: "v2" do #Query Paramenter
    # resources :contacts, :constraints => lambda { |request| request.params[:version] == "2" } do #Query Paramenter
  api_version(:module => "V2", :path => {:value => "v2"}) do
    resources :contacts do
      #Kind
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: "relationship/kind"

      #Phone
      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'

      resource :phone, only: [:update, :create, :destroy]
      resource :phone, only: [:update, :create, :destroy], path: 'relationships/phones'

      #Address
      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
