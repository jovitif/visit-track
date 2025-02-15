class UnidadesController < ApplicationController
    def index
      @unidades = Unidade.all
    end
  
    def new
      @unidade = Unidade.new
    end

    def create
      @unidade = Unidade.new(unidade_params)
      if @unidade.save
        redirect_to unidades_path, notice: 'Unidade criada com sucesso!'
      else
        render :new
      end
    end
  
    private
  
    def unidade_params
      params.require(:unidade).permit(:nome, :descricao, setor_ids: [])
    end
    
  end
  