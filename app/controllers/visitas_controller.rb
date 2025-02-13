require 'base64'
require 'securerandom'

class VisitasController < ApplicationController

  def index
    @visitas = Visita.includes(:funcionario, :visitante).order(created_at: :desc)
  end
  
  def new
    @visita = Visita.new
    @funcionarios = User.where(role: :funcionario)  # Busca usuários com role 'funcionario'
    @visitantes = User.where(role: :visitante)      # Busca usuários com role 'visitante'
  end
  
  def create
    @visita = Visita.new(visita_params)

    # Se houver uma foto em Base64, convertemos para um arquivo real
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

  private

  def visita_params
    params.require(:visita).permit(:idfuncionario, :idvisitante)
  end

  def salvar_foto_base64(base64_str)
    # Decodifica a string Base64
    data_uri = base64_str.split(',')[1]
    decoded_image = Base64.decode64(data_uri)
  
    # Define o caminho e o nome do arquivo
    file_name = "foto_#{SecureRandom.uuid}.png"
    file_path = Rails.root.join('public', 'uploads', file_name)
  
    # Garante que o diretório 'public/uploads' exista
    FileUtils.mkdir_p(File.dirname(file_path))
  
    # Salva o arquivo
    File.open(file_path, 'wb') do |file|
      file.write(decoded_image)
    end
  
    # Retorna o caminho relativo para salvar no banco
    "/uploads/#{file_name}"
  end
end
