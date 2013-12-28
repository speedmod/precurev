Prekara::Application.routes.draw do
  root 'songs#index'
  resources :songs do
    collection do
      get :mobile
      post :search
    end
  end
end
