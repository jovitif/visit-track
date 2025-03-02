class UsuariosController < ApplicationController
    before_action :authenticate_user! # Garante que o usuário esteja logado
    before_action :set_usuario, only: [:edit, :update]

    def index
      @usuarios = User.where.not(role: 'visitante').page(params[:page]).per(10)
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

    def edit
      # Aqui estamos carregando o usuário para editar, a partir do ID
    end
  
    def update
      if @usuario.update(usuario_params)
        redirect_to usuarios_path, notice: "Usuário atualizado com sucesso!"
      else
        render :edit
      end
    end

    private
  def set_usuario
    @usuario = User.find(params[:id])  # Certifique-se de que o ID está sendo passado corretamente
  rescue ActiveRecord::RecordNotFound
    redirect_to usuarios_path, alert: "Usuário não encontrado"
  end  
    def usuario_params
      params.require(:user).permit(:nome, :email, :password, :password_confirmation, :role, :cpf, :telefone)
    end
end
