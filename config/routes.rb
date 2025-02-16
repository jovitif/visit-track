Rails.application.routes.draw do
  get 'administrador_dashboard', to: 'dashboards#administrador'
  get 'atendente_dashboard', to: 'dashboards#atendente'
  get 'funcionario_dashboard', to: 'dashboards#funcionario'
  get 'visitante_dashboard', to: 'dashboards#visitante'
  get '/funcionarios', to: 'funcionarios#index'

  resources :setores do
    member do
      get 'funcionarios'
    end
  end
  
  resources :unidades
  resources :setores
  resources :funcionarios
  resources :usuarios
  # Outras rotas do Devise
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :visitas
  resources :setores, path: 'setores'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get 'visitas/load_funcionarios', to: 'visitas#load_funcionarios'

  resources :visitas do
    collection do
      get 'load_funcionarios' # Ação que carrega os funcionários por setor
    end
  end

  
  resources :visitas do
    collection do
      get 'anteriores'  # Rota para visitas anteriores
    end
    member do
      patch :confirmar  # Rota para confirmar visita
    end
  end

  # Rotas para o dashboard
  get 'dashboard/administrador', to: 'dashboards#administrador'
  get 'dashboard/atendente', to: 'dashboards#atendente'
  get 'dashboard/funcionario',   to: 'dashboards#funcionario'
  get 'dashboard/visitante',     to: 'dashboards#visitante'

  # Defines the root path route ("/")
  # root "posts#index"
  # Define a tela de login como root corretamente com devise_scope
  devise_scope :user do
    root to: "devise/sessions#new"
  end
end
