class User < ApplicationRecord
  attribute :role, :integer, default: 1

  enum role: { administrador: 0, atendente: 1, funcionario: 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true
end
