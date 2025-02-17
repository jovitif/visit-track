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
    # Carregar setores da unidade do usuário logado
    @setors = current_user.unidade.present? ? current_user.unidade.setors : []
    @visitantes = User.where(role: :visitante)
  end
  

  def create
    visitante_params = params.require(:visita).permit(visitante: [:nome, :cpf, :telefone])
    visitante_data = visitante_params[:visitante]
  
    visitante = User.find_by(cpf: visitante_data[:cpf])
  
    if visitante.nil?
      dummy_email = "#{visitante_data[:cpf].gsub(/\D/, '')}@example.com"
      random_password = SecureRandom.hex(8)
  
      visitante = User.create(
        nome: visitante_data[:nome],
        cpf: visitante_data[:cpf],
        telefone: visitante_data[:telefone],
        role: :visitante,
        email: dummy_email,
        password: random_password,
        password_confirmation: random_password
      )
    end
  
    @visita = Visita.new(visita_params)
    @visita.visitante = visitante
    @visita.idfuncionario = params[:idfuncionario] if params[:idfuncionario].present?
  
    if @visita.save
      redirect_back fallback_location: visitas_path, notice: "Visita registrada com sucesso!"
    else
      render :new
    end
  end
      
  
  def show
    @visita = Visita.find_by(id: params[:id])
    if @visita.nil?
      flash[:alert] = "Visita não encontrada"
      redirect_to visitas_path
    end
  end
  

  def confirmar
    puts'entrou aqui'
    authorize! :update, @visita
    if @visita.update(confirmado: true)
      redirect_to dashboard_funcionario_path, notice: 'Visita confirmada com sucesso!'
    else
      flash[:alert] = "Erro ao confirmar visita: #{@visita.errors.full_messages.join(', ')}"
      redirect_to dashboard_funcionario_path
    end
  end
  
  
  

  def anteriores
    @visitas_anteriores = Visita.where(idfuncionario: current_user.id, confirmado: true).order(created_at: :desc)
  end
  

  def load_funcionarios
    setor_id = params[:setor_id]
    funcionarios = User.where(setor_id: setor_id)
    render json: funcionarios
  end
 
  private
  def ensure_atendente
    unless current_user.atendente? || current_user.funcionario?
      redirect_to root_path, alert: "Acesso negado."
    end
    end

  def set_visita
    @visita = Visita.find_by(id: params[:id])
    unless @visita
      flash[:alert] = "Visita não encontrada."
      redirect_to visitas_path
    end
  end

  def visita_params
    params.require(:visita).permit(:setor_id, :idfuncionario, :idvisitante, :foto)
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