# app/controllers/funcionarios_controller.rb

class FuncionariosController < ApplicationController
    before_action :authenticate_user! # Garante que o usuário esteja logado
  
    def index
      # Exibir somente usuários com role 'funcionario' ou 'administrador'
      @funcionarios = User.where(role: [:funcionario, :administrador])
    end
  end
  