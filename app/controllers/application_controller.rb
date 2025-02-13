class ApplicationController < ActionController::Base
 # before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Você não tem permissão para acessar essa página."
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cpf])
  end
end
