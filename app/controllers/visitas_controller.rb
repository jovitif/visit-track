require 'base64'
require 'securerandom'

class VisitasController < ApplicationController
  before_action :set_visita, only: [:confirmar]
  before_action :authenticate_user!
  before_action :ensure_atendente

  def index
    @visitas = Visita.includes(:funcionario, :visitante).order(created_at: :desc)
  end
  
  def new
    @visita = Visita.new
    # Carrega os setores da unidade do usuário logado
    @setors = current_user.unidade.present? ? current_user.unidade.setors : []
    @visitantes = User.where(role: :visitante) # ou conforme sua lógica
  end
  

  def create
    @visita = Visita.new(visita_params)

    if params[:visita][:foto].present?
      @visita.foto = salvar_foto_base64(params[:visita][:foto])
    end

    if @visita.save
      redirect_to visita_path(@visita), notice: 'Visita registrada com sucesso!'
    else
      render :new
    end
  end

  def show
    @visita = Visita.find(params[:id])
  end

  def confirmar
    if @visita
      @visita.update(confirmado: true)
      redirect_to dashboard_funcionario_path, notice: 'Visita confirmada com sucesso!'
    else
      redirect_to dashboard_funcionario_path, alert: 'Erro: Visita não encontrada.'
    end
  end

  def anteriores
    # Buscar visitas confirmadas do funcionário atual
    @visitas = Visita.where(funcionario_id: current_user.id, confirmado: true).order(created_at: :desc)
  end

   # Ação que retorna os funcionários de um setor
   def load_funcionarios
    setor_id = params[:setor_id]
    # Encontre os funcionários que pertencem ao setor selecionado
    funcionarios = User.where(setor_id: setor_id).where(role: 'funcionario')

    # Retorne os funcionários em formato JSON
    render json: funcionarios.map { |f| { id: f.id, nome: f.nome } }
  end
 
  private
  def ensure_atendente
    redirect_to root_path, alert: "Acesso negado." unless current_user.atendente?
  end

  def set_visita
    @visita = Visita.find_by(id: params[:id]) # Use find_by para evitar exceção se o ID não existir
  end
  def visita_params
    params.require(:visita).permit(:idfuncionario, :idvisitante)
  end

  def salvar_foto_base64(base64_str)
    data_uri = base64_str.split(',')[1]
    decoded_image = Base64.decode64(data_uri)
  
    file_name = "foto_#{SecureRandom.uuid}.png"
    file_path = Rails.root.join('public', 'uploads', file_name)
  
    FileUtils.mkdir_p(File.dirname(file_path))
  
    File.open(file_path, 'wb') do |file|
      file.write(decoded_image)
    end
  
    "/uploads/#{file_name}"
  end
end