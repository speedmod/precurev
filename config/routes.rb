Prekara::Application.routes.draw do
  root 'songs#index'
  resources :songs do
    collection do
      post :search
    end
  end
end
