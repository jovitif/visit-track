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
      redirect_to setores_path, notice: 'Setor criado com sucesso!'
    else
      puts @setor.errors.full_messages # Adicionando um debug
      render :new
    end
  end
  
  

  def edit
  end

  def update
    if @setor.update(setor_params)
      redirect_to setore_path(@setor), notice: 'Setor atualizado com sucesso!'
    else
      render :edit
    end
  end

  def por_unidade
    setores = Setor.where(unidade_id: params[:unidade_id])
    render json: setores
  end
  
  def destroy
    @setor.destroy
    redirect_to setores_path, notice: 'Setor excluído com sucesso!'
  end

  def show
    @setor = Setor.find(params[:id])
  end
  def funcionarios
    @setor = Setor.find(params[:id])
    @funcionarios = @setor.funcionarios
    respond_to do |format|
      format.json { render json: @funcionarios.select(:id, :nome) }
    end
  end
  private

  def set_setor
    @setor = Setor.find(params[:id])
  end

  def setor_params
    params.require(:setor).permit(:nome, :descricao, :unidade_id)
  end
  
end
