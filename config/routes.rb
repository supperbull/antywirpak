Rails.application.routes.draw do

  devise_for :users
  resources :articles do
    member do
        put "like", to: "articles#upvote"
        put "dislike", to: "articles#downvote"
    end
  resources :comments
end
  root 'articles#index'
end
