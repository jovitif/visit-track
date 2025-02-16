# app/controllers/funcionarios_controller.rb

class FuncionariosController < ApplicationController
    before_action :authenticate_user! # Garante que o usuário esteja logado
  
    def index
      @usuarios = User.all
    end
  end
  