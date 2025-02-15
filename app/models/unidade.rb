class Unidade < ApplicationRecord
  self.table_name = 'unidades'  # Nome da tabela deve ser "unidades"
  
  # Associações
  has_and_belongs_to_many :setors, join_table: 'setors_unidades' # Relação entre unidades e setores
  has_many :users # Uma unidade pode ter vários atendentes
  has_many :setors
  
  validates :nome, presence: true, uniqueness: true
  validates :descricao, presence: true
end
