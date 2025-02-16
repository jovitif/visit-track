class UsuariosController < ApplicationController
    before_action :authenticate_user! # Garante que o usuário esteja logado

    def index
      @usuarios = User.all
    end

    def new
      @usuario = User.new
    end
  
    def create
      @usuario = User.new(usuario_params)
      
      if @usuario.save
        redirect_to root_path, notice: "Usuário criado com sucesso!"
      else
        render :new
      end
    end
    private
  
    def usuario_params
      params.require(:user).permit(:nome, :email, :password, :password_confirmation, :role, :cpf, :telefone)
    end
end
