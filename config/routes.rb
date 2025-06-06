Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }

  root "static_pages#top"

  resources :posts, only: %i[index new create show edit destroy update] do
    collection do
      get "map"
    end
  end

  # 開発環境限定で/letter_openerにアクセスできるようにする
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
