Rails.application.routes.draw do
  get "/", to: redirect("http://umn-asr.github.io/liberal_education_courses/")
  resources :courses, only: :index
end
