class Unidade < ApplicationRecord
  self.table_name = 'setors'  # Informa ao Rails que o nome da tabela é "setors"
  
  has_and_belongs_to_many :unidades, join_table: 'setors_unidades'
    
    validates :nome, presence: true, uniqueness: true
    validates :descricao, presence: true
    has_many :users # Uma unidade pode ter vários atendentes
    has_many :setors

  end
  