Rails.application.routes.draw do

  resources :events

  namespace :ember do
    get '/users/:user_id/projects', to: 'projects#index_user'
    get '/projects', to: 'projects#index'
    post 'projects/save', to: 'projects#save'
    post 'projects/:id/add_visualization', to: 'projects#add_visualization'
    get '/users/quick_load', to: 'users#quick_load'
    post '/pdf/generate', to: 'pdf#generate'
    resources :projects
    namespace :ticket do
      resources :extensions,        only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
          post :decline
        end
      end
      resources :freezings,         only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
          post :decline
        end
      end
      resources :guest_visits,      only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
        end
      end
      resources :recalls,           only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
        end
      end
      resources :messages,          only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
        end
      end
      resources :tutoring_requests, only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
          post :decline
        end
      end
      resources :workout_requests,  only: [:index, :show, :create, :update, :destroy] do
        member do
          post :close
          post :decline
        end
      end
    end
    resources :users,               only: [:index, :show, :create, :update, :destroy] do
      collection do
        post 'authenticate'
      end
    end

    resources :visualizations

    namespace :card do
      resources :templates
    end

    namespace :club do
      resources :shedules
      resources :images
    end
    namespace :coach do
      resources :achievements
      resources :specializations
      resources :educations
    end

    resources :schedule_templates
    resources :permissions, only: :show
    resources :qrs
    resources :loyalties
    resources :coaches
    resources :training_packages
    resources :franchises
    resources :clubs
    resources :score_rules
    resources :services
    resources :cards
    resources :news
    resources :user_types
    resources :pushes
    resources :push_channels
    resources :roles, only: [:index, :show]
    namespace :reward do
      resources :templates
    end
    namespace :workout do
      resources :images
      resources :types
      resources :templates
    end
    resources :workouts
    resources :schedule_workouts

    namespace :history do
      resources :rewards
      resources :scores
    end
  end

  namespace :mobile do
    namespace :ticket do
      resources :extensions,        only: [:index, :show, :create]
      resources :freezings,         only: [:index, :show, :create]
      resources :messages,          only: [:index, :show, :create]
      resources :recalls,           only: [:index, :show, :create]
      resources :guest_visits,      only: [:index, :show, :create]
      resources :tutoring_requests, only: [:index, :show, :create, :destroy]
      resources :workout_requests,  only: [:index, :show, :create, :destroy]
    end

    get '/projects', to: 'projects#index'

    namespace :reward do
      resources :templates, only: [:index, :show]
    end

    resources :cards,      only: [:index, :show] do
      member do
        post 'break_frost'
        post 'add_social_score'
      end
    end

    resources :clubs,       only: [:index, :show]
    resources :coaches,     only: [:index, :show]
    resources :franchises,  only: [:index, :show]
    resources :client_devises,  only: :create
    resources :news,        only: [:index, :show]

    resources :qrs,         only: [:index, :show] do
      member do
        post 'charge'
      end
    end

    resources :rewards,    only: [:show] do
      member do
        post 'reserve'
      end
    end

    resources :tutorings,  only: [:index, :show, :destroy]

    resources :users,      only: [:index, :show, :update] do
      collection do
        post 'send_password_via_sms'
        post 'authenticate'
        post 'generate_guest'
        get 'get_waiting_rewards'
        get 'get_issued_rewards'
      end
    end

    resources :workouts,   only: [:index, :show] do
      member do
        post :add_me
        post :remove_me
      end
    end

    resources :shares, only: :create
  end

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
