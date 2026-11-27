Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :rooms, only: %i[index show create destroy]
    end
  end
end
