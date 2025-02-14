class DashboardsController < ApplicationController
    before_action :authenticate_user! # Garante que o usuário esteja logado
    before_action :check_role # Verifica a role antes de acessar o painel
  
    def administrador
      # Adicione aqui qualquer lógica necessária para o painel do administrador
      # Exemplo: Carregar informações dos usuários, estatísticas, etc.
      @users = User.all # Exemplo: Carregar todos os usuários
    end
  
    def atendente
      # Lógica para o painel de atendente
    end
  
    def funcionario
      # Lógica para o painel de funcionário
    end
  
    def visitante
      # Lógica para o painel de visitante
    end
  
    private
  
    def check_role
      case action_name
      when "administrador"
        redirect_to root_path unless current_user.administrador?
      when "atendente"
        redirect_to root_path unless current_user.atendente?
      when "funcionario"
        redirect_to root_path unless current_user.funcionario?
      when "visitante"
        redirect_to root_path unless current_user.visitante?
      end
    end
  end
  