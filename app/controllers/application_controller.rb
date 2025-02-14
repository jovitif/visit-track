class ApplicationController < ActionController::Base
 # before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Você não tem permissão para acessar essa página."
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cpf])
  end
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redireciona para a página de login
  end
   # Redireciona após o login com base na role
   def after_sign_in_path_for(resource)
    case resource.role
    when "administrador"
      # Redireciona para a página do administrador
      administrador_dashboard_path
    when "atendente"
      # Redireciona para a página do atendente
      atendente_dashboard_path
    when "funcionario"
      # Redireciona para a página do funcionário
      funcionario_dashboard_path
    when "visitante"
      # Redireciona para a página do visitante
      visitante_dashboard_path
    else
      super # Redirecionamento padrão (geralmente para a raiz do site)
    end
  end
end
