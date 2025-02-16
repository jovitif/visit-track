class FuncionariosController < ApplicationController
  before_action :set_usuario, only: [:edit, :update]

  def index
    @usuarios = User.all
  end

  def edit
    @usuario = User.find(params[:id])
    @unidades = Unidade.all
    @setores = @usuario.unidade_id ? Setor.where(unidade_id: @usuario.unidade_id) : []
  end
  

  def update
    if @usuario.update(usuario_params)
      redirect_to funcionarios_path, notice: "Usuário atualizado com sucesso!"
    else
      render :edit
    end
  end

  private

  def set_usuario
    @usuario = User.find(params[:id])
  end

  def usuario_params
    # Permite atualizar diferentes atributos conforme o papel do usuário
    if @usuario.role == "atendente"
      params.require(:user).permit(:nome, :email, :cpf, :telefone, :unidade_id)
    elsif @usuario.role == "funcionario"
      params.require(:user).permit(:nome, :email, :cpf, :telefone, :unidade_id, :setor_id)
    else
      # Caso seja administrador ou outro, limita os parâmetros editáveis
      params.require(:user).permit(:nome, :email, :cpf, :telefone)
    end
  end
end
