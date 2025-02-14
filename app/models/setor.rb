class Setor < ApplicationRecord
    has_and_belongs_to_many :funcionarios, 
                            class_name: 'User', 
                            join_table: 'setores_funcionarios', 
                            association_foreign_key: 'user_id'
  
    has_many :visitas, through: :funcionarios
  
    validates :nome, presence: true, uniqueness: true
    validates :descricao, presence: true
  end
  