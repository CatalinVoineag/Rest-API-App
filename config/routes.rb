Rails.application.routes.draw do
  
  namespace :api do
  	namespace :v1 do

			post 'store_content', to: 'pages#store_content'

  		resources :pages, only: [:index]

  	

  	end
  end

end
