class SetoresController < ApplicationController
  before_action :set_setor, only: %i[show edit update destroy]

  def index
    @setores = Setor.all
  end

  def show
  end

  def new
    @setor = Setor.new
  end

  def create
    @setor = Setor.new(setor_params)
    if @setor.save
      redirect_to setores_path, notice: 'Setor criado com sucesso!'  # Redireciona para a lista de setores
    else
      render :new
    end
  end
  

  def edit
  end

  def update
    if @setor.update(setor_params)
      redirect_to @setor, notice: 'Setor atualizado com sucesso!'
    else
      render :edit
    end
  end

  def destroy
    @setor.destroy
    redirect_to setores_path, notice: 'Setor excluído com sucesso!'
  end

  def show
    @setor = Setor.find(params[:id])
  end

  private

  def set_setor
    @setor = Setor.find(params[:id])
  end

  def setor_params
    params.require(:setor).permit(:nome, :descricao, funcionario_ids: [])
  end
end
