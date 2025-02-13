class User < ApplicationRecord
  attribute :role, :integer, default: nil
  
  enum role: { administrador: 0, atendente: 1, funcionario: 2, visitante: 3 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true
end