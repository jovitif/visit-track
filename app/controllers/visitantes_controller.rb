class VisitantesController < ApplicationController
    def buscar
      visitante = User.find_by(cpf: params[:cpf])
      if visitante
        render json: { encontrado: true, nome: visitante.nome, telefone: visitante.telefone }
      else
        render json: { encontrado: false }
      end
    end
  end
  