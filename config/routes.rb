Prekara::Application.routes.draw do
  root 'songs#index'
  resources :songs do
    collection do
      get :mobile
      post :search
      get :rascal
    end
  end
end
