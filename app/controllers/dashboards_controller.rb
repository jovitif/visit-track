class DashboardsController < ApplicationController
    before_action :authenticate_user! # Garante que o usuário esteja logado
    before_action :check_role # Verifica a role antes de acessar o painel
  
    def administrador
      # Calcula a quantidade de visitas marcadas
      @visitas_marcadas = Visita.where(confirmado: nil) # Ou onde confirmado: false
      @visitas_confirmadas = Visita.where(confirmado: true)
      # Total de visitas
      @total_visitas = Visita.count

      # Pega as últimas 5 visitas
      @ultimas_visitas = Visita.order(created_at: :desc).limit(5)
  
      # Passando essas informações para a view
      puts "Visitas marcadas: #{@visitas_marcadas.count}"
      puts "Visitas confirmadas: #{@visitas_confirmadas.count}"
      puts "Últimas visitas: #{@ultimas_visitas.map(&:created_at)}"
      puts 'admin'
      # Adicione aqui qualquer lógica necessária para o painel do administrador
      # Exemplo: Carregar informações dos usuários, estatísticas, etc.
      @users = User.all # Exemplo: Carregar todos os usuários

    end

   
  
    def atendente
      puts 'atendente'
      @visitas = Visita.joins(:funcionario)
      .where(users: { unidade_id: current_user.unidade_id })
      .order(created_at: :desc)
      render "visitas/index"
    end    
  
    def funcionario
      puts 'funcionario'
      # Busca as visitas agendadas para o funcionário atual (que ainda não foram confirmadas)
      @visitas = Visita.where(idfuncionario: current_user.id, confirmado: [false, nil]).order(created_at: :desc)
    end
  
    def visitante
      puts 'visitante'
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
  