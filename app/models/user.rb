class User < ApplicationRecord
  attribute :role, :integer, default: nil
  
  enum role: { administrador: 0, atendente: 1, funcionario: 2, visitante: 3 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true

  has_and_belongs_to_many :setores, join_table: 'setores_funcionarios'

  belongs_to :unidade, optional: true
  belongs_to :setor, optional: true 

  
end
