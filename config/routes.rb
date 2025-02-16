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
  get '/setores_por_unidade/:unidade_id', to: 'setores#por_unidade'

  resources :unidades
  resources :setores
  resources :funcionarios
  resources :usuarios
  # Outras rotas do Devise
  devise_for :users

  # Rotas para visitas
  resources :visitas do
    collection do
      get :load_funcionarios
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
